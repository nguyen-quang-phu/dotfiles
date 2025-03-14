{
  lib,
  ...
}: {
  # `programs.git` will generate the config file: ~/.config/git/config
  # to make git use this config file, `~/.gitconfig` should not exist!
  #
  #    https://git-scm.com/docs/git-config#Documentation/git-config.txt---global
  home.activation.removeExistingGitconfig = lib.hm.dag.entryBefore ["checkLinkTargets"] ''
    rm -f ~/.gitconfig
  '';

  programs = {
    git = {
      enable = true;
      lfs.enable = true;

      includes = [
        {
          condition = "gitdir:~/.config/";
          contents = {
            user = {
              email = "nqphu1998@gmail.com";
              # email = builtins.readFile(config.sops.secrets.email.path);
              name = "keynold";
            };
          };
        }
        {
          condition = "gitdir:~/Code/Personal/";
          contents = {
            user = {
              email = "nqphu1998@gmail.com";
              name = "keynold";
            };
          };
        }
        {
          condition = "gitdir:~/Code/GO/GIGADMIN/harvey/";
          contents = {
            user = {
              email = "harvey.nguyen.goldenowl" + "@" + "gmail" + "." + "com";
              name = "harvey-gig";
            };
          };
        }
        {
          condition = "gitdir:~/Code/GO/GIGADMIN/sean/";
          contents = {
            user = {
              email = "sean.tran.goldenowl" + "@" + "gmail" + "." + "com";
              name = "sean-gig";
            };
          };
        }
        {
          condition = "gitdir:~/Code/GO/GIGADMIN/troy/";
          contents = {
            user = {
              email = "troy.tran.goldenowl" + "@" + "gmail" + "." + "com";
              name = "troy-gig";
            };
          };
        }
        {
          condition = "gitdir:~/Code/GO/EZYCAL/zane/";
          contents = {
            user = {
              email = "zane.le.goldenowl" + "@" + "gmail" + "." + "com";
              name = "Zane Le";
            };
          };
        }
        {
          condition = "gitdir:~/Code/GO/ARINEX/charlie/";
          contents = {
            user = {
              email = "charlie.nguyen.goldenowl" + "@" + "gmail" + "." + "com";
              name = "Charlie";
            };
          };
        }
        {
          condition = "gitdir:~/Code/GO/ARINEX/alan/";
          contents = {
            user = {
              email = "alan.tran.goldenowl" + "@" + "gmail" + "." + "com";
              name = "alan-tran-goldenowl";
            };
          };
        }
        {
          condition = "gitdir:~/Code/GO/CREWCALL/zendy/";
          contents = {
            user = {
              email = "keynold.nguyen.goldenowl" + "@" + "gmail" + "." + "com";
              name = "Keynold Nguyễn";
            };
          };
        }
        {
          condition = "gitdir:~/Code/GO/RESTORIFIC/marcus/";
          contents = {
            user = {
              email = "marcus.nguyen.goldenowl" + "@" + "gmail" + "." + "com";
              name = "Marcus Nguyễn";
            };
          };
        }
        {
          condition = "gitdir:~/Code/GO/MERLIN/tim/";
          contents = {
            user = {
              email = "tim.luong.goldenowl" + "@" + "gmail" + "." + "com";
              name = "tim-merlin";
            };
          };
        }
        {
          condition = "gitdir:~/Code/GO/AITIS/gavin";
          contents = {
            user = {
              email = "gavin.tran.goldenowl" + "@" + "gmail" + "." + "com";
              name = "Gavin-Tran-GoldenOwl";
            };
          };
        }
      ];

      extraConfig = {
        init.defaultBranch = "main";
        repack.usedeltabaseoffset = "true";
        color.ui = "auto";
        diff.algorithm = "histogram"; # a much better diff
        help.autocorrect = 10; # 1 second warning to a typo'd command
        core.whitespace = "fix,-indent-with-non-tab,trailing-space,cr-at-eol";
        branch = {
          autosetupmerge = "true";
          sort = "committerdate";
        };
        commit.verbose = true;

        fetch.prune = true;
        pull.ff = "only"; # equivalent to --ff-only
        pull.rebase = true;
        push = {
          default = "current";
          followTags = true;
          autoSetupRemote = true;
        };
        merge = {
          stat = "true";
          conflictstyle = "zdiff3";
          tool = "meld";
        };
        mergetool = {
          meld = {
            path = "/usr/local/bin/meld";
          };
        };

        rebase = {
          autoSquash = true;
          autoStash = true;
        };

        rerere = {
          enabled = true;
          autoupdate = true;
        };
        diff.mnemonicprefix = true;

        # prevent data corruption
        transfer.fsckObjects = true;
        fetch.fsckObjects = true;
        receive.fsckObjects = true;
        url = {
          # "git@github.com:".insteadOf = "https://github.com/";
          # "ssh://git@github.com".pushInsteadOf = "gh:";
          # "git@gitlab.com:".insteadOf = "https://gitlab.com/";
          # "ssh://git@gitlab.com".pushInsteadOf = "gl:";
        };
      };

      # signing = {
      #   key = "xxx";
      #   signByDefault = true;
      # };

      delta = {
        enable = true;
        options = {
          navigate = true;
          side-by-side = true;
          line-numbers = true;
        };
      };

      aliases = {
        email = "config --local user.email";
        name = "config --local user.name";

        br = "rev-parse --abbrev-ref HEAD";
        can = "!git add . && git status && git commit --amend --no-edit";
        cara = "!git commit --amend --reset-author --no-edit";
        colast = "!git checkout -";
        fsck = "fsck --unreachable | grep commit | cut -d' ' -f3 | xargs git log --merges --no-walk --grep=WIP";
        hide = "update-index --skip-worktree";
        pf = "push --force-with-lease";
        rsho = "reset --hard ORIG_HEAD";
        rss = "reset --soft HEAD~1";
        s = "stash -u";
        sp = "stash apply stash@{0}";
        unhide = "update-index --no-skip-worktree";
      };
      ignores = [
        ".DS_Store"
        "Thumbs.db"
        ".devenv"
        ".direnv"
        ".lazy.lua"
        ".envrc"
        "devenv.yaml"
        "devenv.nix"
        "justfile"
        "vendor"
        ".ignore"
        "Gemfile.local"
        "Gemfile.local.lock"
        "bin"
      ];
    };

    git-cliff = {
      enable = true;
    };

    lazygit = {
      enable = true;
      settings = {
        os = {
          editPreset = "nvim-remote";
          openLink = "open \"$(echo \"{{link}}\" | sed 's/%2F/\\//g')\"";
        };
        customCommands = [
          {
            key = "c";
            command = "npx better-commits";
            description = "commit with better-commits";
            context = "files";
            loadingText = "opening better-commits tool";
            subprocess = true;
          }
          {
            key = "n";
            command = "npx -p better-commits better-branch";
            description = "new branch with better-branch";
            context = "localBranches";
            loadingText = "opening better-branch tool";
            subprocess = true;
          }
        ];
      };
    };
    gh = {
      enable = true;
    };
    gh-dash = {
      enable = true;
    };
  };
}
