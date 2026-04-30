import fs from 'node:fs'

const commitMsgFile = process.argv[2];
if (!commitMsgFile) {
  console.error('No commit message file path provided.');
  process.exit(1);
}

if (!fs.existsSync(commitMsgFile)) {
  console.error('Commit message file does not exist:', commitMsgFile);
  process.exit(1);
}

const commitMsg = fs.readFileSync(commitMsgFile, 'utf8').trim();

const prefixes = {
  feat: '✨',
  fix: '🐛',
  refactor: '♻️',
  'BREAKING CHANGE': '🚀',
  test: '✅',
  chore: '⚡️',
  revert: '⏪',
  hotfix: '🚑️',
  wip: '🚧',
  enhance: '⭐',
  docs: '📝',
  config: '🔧',
  security: '🔒',
  perf: '⚡️',
};

const prependEmoji = (message) => {
  const prefix = Object.keys(prefixes).find((p) => message.startsWith(p));
  if (prefix) {
    return `${prefixes[prefix]} ${message}`;
  }
  return message;
};

const updatedMsg = prependEmoji(commitMsg);
fs.writeFileSync(commitMsgFile, updatedMsg);
