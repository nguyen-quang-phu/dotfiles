// https://developer.atlassian.com/cloud/bitbucket/rest/api-group-pullrequests/#api-repositories-workspace-repo-slug-pullrequests-post
// https://id.atlassian.com/manage-profile/security/api-tokens
const { BB_USER, BB_APP_PASSWORD } = process.env;
const DEFAULT_BRANCH = 'develop';
const JIRA_DOMAIN = 'https://lumin.atlassian.net/browse';

const reviewers = [
  {
    uuid: '{b63f2198-083e-49fe-a447-e2b72b310dcd}', // Phong
  },
  {
    uuid: '{d8451525-bd59-40dc-8a70-40e472244869}', // Thịnh
  },
  {
    uuid: '{a6b4efc9-04ea-4ef4-a04e-636d72b9f1c2}', // Long
  },
  // {
  //   uuid: '{26f45994-a4b0-42bc-b98a-1e5f2f646801}', // Trung
  // },
  {
    uuid: '{f6e9ee5a-9699-4975-8d58-3689814ede15}', // Tiên
  },
];
const arguments_ = process.argv.slice(2);
const targetArgumentIndex = arguments_.indexOf('--target');
const TARGET_BRANCH = targetArgumentIndex === -1 ? DEFAULT_BRANCH : arguments_[targetArgumentIndex + 1];

const https = require('https');
const { execSync } = require('child_process');
const readline = require('readline');

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
});

const runGit = (command) => {
  try {
    return execSync(command, { encoding: 'utf8' }).trim();
  } catch {
    console.error(`Error running git command: ${command}`);
    process.exit(1);
  }
};

const getRepoInfo = () => {
  const origin = runGit('git remote get-url origin');

  const match = origin.match(/bitbucket\.org[:/]([^\/]+)\/([^\/]+?)(?:\.git)?$/);

  if (!match) {
    console.error('Error: Could not parse Bitbucket repository URL');
    console.error(`Origin URL: ${origin}`);
    process.exit(1);
  }

  return {
    workspace: match[1],
    repo: match[2].replace(/\.git$/, ''),
  };
};

const getCurrentBranch = () => runGit('git rev-parse --abbrev-ref HEAD');

const extractTicketsFromCommits = () => {
  const currentBranch = getCurrentBranch();
  const commitRange = `${TARGET_BRANCH}..${currentBranch}`;
  const log = runGit(`git log ${commitRange} --oneline --pretty=format:"%s"`);

  const tickets = new Set();

  const extractFromText = (text) => {
    for (const subject of text.split('\n')) {
      const matches = subject.matchAll(/\b(LT[-–—]?[0-9]+)\b/gi);
      for (const match of matches) {
        const ticket = match[1]
          .replaceAll(/[-–—]/g, '-')
          .toUpperCase();
        if (/^LT-\d+$/.test(ticket)) {
          tickets.add(ticket);
        }
      }
    }
  };

  // 1. Extract tickets from commits
  extractFromText(log);

  // 2. If empty → extract from branch name
  if (tickets.size === 0) {
    extractFromText(currentBranch);
  }

  return [...tickets].sort();
};

const getBranchInfo = () => {
  const branch = runGit('git rev-parse --abbrev-ref HEAD');
  const defaultTitle = runGit('git log -1 --pretty=%s');
  const lastCommitMessage = runGit('git log -1 --pretty=%B');
  const ticketMatch = branch.match(/(?:^|\/)([A-Z]{2,}-?\d+|[A-Z]+-\d+|[A-Z]+\d+|\d{3,})/i);
  const ticketId = ticketMatch ? ticketMatch[1].replaceAll(/[^A-Z0-9-]/g, '') : null;

  return {
    branch, defaultTitle, lastCommitMsg: lastCommitMessage, ticketId,
  };
};

const formatTicketLink = (ticket) => `[${ticket}](${JIRA_DOMAIN}/${ticket})`;
const buildDescription = (tickets) => {
  const jiraLines =
    tickets.length > 0
      ? tickets
          .map(
            (ticket) =>
              `[https://lumin.atlassian.net/browse/${ticket}](https://lumin.atlassian.net/browse/${ticket}){: data-inline-card='' }`
          )
          .join('\n\n')
      : '- _Không detect được ticket LT nào_';

  return `## Summary

${jiraLines}

## Dependencies PR

_(PR which need to be merged together)_

## Checklist

* No error nor warning in the console.
* No linter error
* All fonts should have \`WOFF2\` format
* All images should be optimized (compress and resize)
* All videos should have \`webm\` and \`mov\` format
* Lazy load all non-critical and heavy components

## Notes

**Does it impact any other area of the project?**

**Any changes in the UI (Screenshots)?**
`;
};

const createPullRequest = (workspace, repo, data, auth) => new Promise((resolve, reject) => {
  const postData = JSON.stringify(data);

  const options = {
    hostname: 'api.bitbucket.org',
    path: `/2.0/repositories/${workspace}/${repo}/pullrequests`,
    method: 'POST',
    auth,
    headers: {
      'Content-Type': 'application/json',
      'Content-Length': Buffer.byteLength(postData),
    },
  };

  const request = https.request(options, (res) => {
    let body = '';

    res.on('data', (chunk) => {
      body += chunk;
    });

    res.on('end', () => {
      if (res.statusCode === 201) {
        try {
          const json = JSON.parse(body);
          resolve(json);
        } catch {
          reject(new Error(`Failed to parse response: ${body}`));
        }
      } else {
        reject(new Error(`API Error (${res.statusCode}): ${body}`));
      }
    });
  });

  request.on('error', (error) => {
    reject(error);
  });

  request.write(postData);
  request.end();
});

const main = async () => {
  const repoInfo = getRepoInfo();
  const branchInfo = getBranchInfo();

  console.log('\n📝 Creating Pull Request');
  console.log(`Repository: ${repoInfo.workspace}/${repoInfo.repo}`);
  console.log(`Source branch: \u001B[33m${branchInfo.branch}\u001B[0m`);
  console.log(`Target branch: \u001B[32m${TARGET_BRANCH}\u001B[0m\n`);
  // Extract tickets
  const tickets = extractTicketsFromCommits();
  console.log(`\nTickets detected (${tickets.length}):`);
  for (const t of tickets) {
    console.log(`  • ${formatTicketLink(t)}`);
  }

  const title = branchInfo.defaultTitle;
  const description = buildDescription(tickets);
  const prData = {
    title,
    description,
    source: {
      branch: {
        name: branchInfo.branch,
      },
    },
    destination: {
      branch: {
        name: TARGET_BRANCH,
      },
    },
    close_source_branch: false,
    draft: true,
    reviewers,
  };

  try {
    console.log('\n⏳ Creating pull request...');
    const result = await createPullRequest(
      repoInfo.workspace,
      repoInfo.repo,
      prData,
      `${BB_USER}:${BB_APP_PASSWORD}`,
    );

    const prUrl = result.links.html.href;
    console.log('\n✅ Pull request created successfully!');
    console.log(`🔗 ${prUrl}\n`);

    try {
      execSync(`open "${prUrl}"`);
    } catch {
    }
  } catch (error) {
    console.error('\n❌ Error creating pull request:');
    console.error(error.message);
    process.exit(1);
  } finally {
    rl.close();
  }
};

main().catch((error) => {
  console.error('Unexpected error:', error);
  rl.close();
  process.exit(1);
});
