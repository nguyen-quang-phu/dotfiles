{
  pkgs,
  config,
  osConfig,
  lib,
  ...
}: {
  # home.file.".config/git/hooks/commit-msg" = {
  #   source = ./hooks/commit-msg; # Directory containing your hook scripts
  #   recursive = true;
  #   executable = true;
  # };
  # programs = {
  #   git = {
  #     enable = false;
  #     lfs.enable = true;
  #
  #     includes = [
  #       {
  #         condition = "gitdir:/Users/dev/";
  #         contents = {
  #           user = {
  #             email = "nqphu1998@gmail.com";
  #             name = "keynold";
  #           };
  #         };
  #       }
  #       {
  #         condition = "gitdir:/Users/dev/Code/Lumin/";
  #         contents = {
  #           user = {
  #             email = "phunq@luminpdf.com";
  #             name = "phunq-lumin";
  #           };
  #         };
  #       }
  #     ];
  #     settings = {
  #       pager = {
  #         diff = "diffnav";
  #       };
  #       core = {
  #         symlinks = false;
  #         hooksPath = "${config.home.homeDirectory}/.config/git/hooks"; # 1 second warning to a typo'd command
  #         whitespace = "fix,-indent-with-non-tab,trailing-space,cr-at-eol";
  #         fsmonitor = true;
  #         untrackedCache = true;
  #       }; # Path to your global hooks directory
  #       # signing = {
  #       #   key = "xxx";
  #       #   signByDefault = true;
  #       # };
  #       alias = {
  #         email = "config --local user.email";
  #         name = "config --local user.name";
  #         br = "rev-parse --abbrev-ref HEAD";
  #         can = "!git add . && git status && git commit --amend --no-edit";
  #         cara = "!git commit --amend --reset-author --no-edit";
  #         colast = "!git checkout -";
  #         fsck = "fsck --unreachable | grep commit | cut -d' ' -f3 | xargs git log --merges --no-walk --grep=WIP";
  #         hide = "update-index --skip-worktree";
  #         pf = "push --force-with-lease";
  #         rsho = "reset --hard ORIG_HEAD";
  #         rss = "reset --soft HEAD~1";
  #         s = "stash -u";
  #         sp = "stash apply stash@{0}";
  #         unhide = "update-index --no-skip-worktree";
  #       };
  #
  #       init.defaultBranch = "master";
  #       repack.usedeltabaseoffset = "true";
  #       color.ui = "auto";
  #       diff.algorithm = "histogram"; # a much better diff
  #       help.autocorrect = 10;
  #       branch = {
  #         autosetupmerge = "true";
  #         sort = "committerdate";
  #       };
  #       commit.verbose = true;
  #       submodule.recurse = true;
  #       fetch.prune = true;
  #       # pull.ff = "only"; # equivalent to --ff-only
  #       pull.rebase = true;
  #       push = {
  #         default = "current";
  #         followTags = true;
  #         autoSetupRemote = true;
  #       };
  #       merge = {
  #         stat = "true";
  #         conflictstyle = "zdiff3";
  #         tool = "meld";
  #       };
  #       mergetool = {
  #         meld = {
  #           path = "/usr/local/bin/meld";
  #         };
  #       };
  #
  #       rebase = {
  #         autoSquash = true;
  #         autoStash = true;
  #         updateRefs = true;
  #       };
  #
  #       rerere = {
  #         enabled = false;
  #         autoupdate = true;
  #       };
  #       diff.mnemonicprefix = true;
  #
  #       # prevent data corruption
  #       transfer.fsckObjects = true;
  #       fetch.fsckObjects = true;
  #       receive.fsckObjects = true;
  #       url = {
  #         # "git@github.com:".insteadOf = "https://github.com/";
  #         # "ssh://git@github.com".pushInsteadOf = "gh:";
  #         # "git@gitlab.com:".insteadOf = "https://gitlab.com/";
  #         # "ssh://git@gitlab.com".pushInsteadOf = "gl:";
  #       };
  #     };
  #     ignores = [
  #       ".DS_Store"
  #       ".devenv"
  #       ".direnv"
  #       ".gemini"
  #       ".gitattributes"
  #       ".husky"
  #       ".lazy.lua"
  #       ".oxlintrc.json"
  #       ".serena"
  #       ".specify"
  #       "Thumbs.db"
  #       "bin"
  #       "biome.json"
  #       "data.ms"
  #       "declarations.d.ts"
  #       "git-town.toml"
  #       "justfile"
  #       "keynold_scripts"
  #       "lefthook.yml"
  #       "remote.just"
  #       "rules"
  #       "sgconfig.yml"
  #       "types"
  #       "vendor"
  #     ];
  #   };
  #
  #   delta = {
  #     enable = true;
  #     options = {
  #       navigate = true;
  #       side-by-side = true;
  #       line-numbers = true;
  #     };
  #   };
  #   git-cliff = {
  #     enable = true;
  #   };
  #
  #   gh = {
  #     enable = true;
  #   };
  #   lazygit = {
  #     enable = false;
  #     settings = {
  #       os = {
  #         editPreset = "nvim-remote";
  #         # openLink =
  #         #   if pkgs.stdenv.hostPlatform.isDarwin
  #         #   then "open \"$(echo \"{{link}}\" | sed 's/%2F/\\//g')\""
  #         #   else "xdg-open \"$(echo \"{{link}}\" | sed 's/%2F/\\//g')\"";
  #       };
  #       gui = {
  #         nerdFontsVersion = "3";
  #       };
  #       customCommands = [
  #         # {
  #         #   key = "c";
  #         #   command = "npx better-commits";
  #         #   description = "commit with better-commits";
  #         #   context = "files";
  #         #   loadingText = "opening better-commits tool";
  #         #   output = "terminal";
  #         # }
  #         {
  #           key = "n";
  #           command = "npx -p better-commits better-branch";
  #           description = "new branch with better-branch";
  #           context = "localBranches";
  #           loadingText = "opening better-branch tool";
  #           output = "terminal";
  #         }
  #         # {
  #         #   key = "n";
  #         #   description = "new tag";
  #         #   context = "tags";
  #         #   prompt = [
  #         #     {
  #         #       type= "input";
  #         #       title= "What is the new tag name?";
  #         #        key= "TagName";
  #         #       initialValue= "lumin";
  #         #     }
  #         #   ];
  #         # }
  #       ];
  #     };
  #   };
  # };
}
