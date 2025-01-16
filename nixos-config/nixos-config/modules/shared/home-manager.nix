{ config, pkgs, lib, ... }:

let name = "Keynold";
  user = "harvey";
  email = "nqphu1998@gmail.com"; in
  {
  # https://donsnotes.com/tech/charsets/ascii.html
  # Shared shell configuration
  neovim = {
    enable = true;
    withNodeJs = true;
    withRuby = true;
    withPython3 = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;
  };
  zsh = {
    enable = true;
    autocd = false;
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = lib.cleanSource ./config;
        file = "p10k.zsh";
      }
    ];

    initExtraFirst = ''
      if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
        . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
      fi

      # Define variables for directories
      export PATH=$HOME/.pnpm-packages/bin:$HOME/.pnpm-packages:$PATH
      export PATH=$HOME/.npm-packages/bin:$HOME/bin:$PATH
      export PATH=$HOME/.local/share/bin:$PATH

      # Remove history data we don't want to see
      export HISTIGNORE="pwd:ls:cd"

      # Emacs is my editor
      export ALTERNATE_EDITOR=""
      export EDITOR="emacsclient -t"
      export VISUAL="emacsclient -c -a emacs"

      e() {
          emacsclient -t "$@"
      }

      # nix shortcuts
      shell() {
          nix-shell '<nixpkgs>' -A "$1"
      }

      # Use difftastic, syntax-aware diffing
      alias diff=difft

      # Always color ls and group directories
      alias ls='ls --color=auto'
    '';
  };
  zellij = {
    enable = true;
    # enableZshIntegration = true;
  };
  kitty = {
    enable = false;
    extraConfig = "";
    font.name = "JetBrainsMono Nerd Font";
    font.size = 14;
    shellIntegration.enableZshIntegration = true;
    shellIntegration.mode = "no-title no-cursor";
    themeFile = "Catppuccin-Mocha";

    keybindings = {
      "cmd+1" = "send_text all \\x021";
      "cmd+2" = "send_text all \\x022";
      "cmd+3" = "send_text all \\x023";
      "cmd+4" = "send_text all \\x024";
      "cmd+5" = "send_text all \\x025";
      "cmd+6" = "send_text all \\x026";
      "cmd+7" = "send_text all \\x027";
      "cmd+8" = "send_text all \\x028";
      "cmd+9" = "send_text all \\x029";
      "cmd+enter" = "send_text all \\x02z";
      "cmd+h" = "send_text all \\x02h";
      "cmd+j" = "send_text all \\x02j";
      "cmd+k" = "send_text all \\x02k";
      "cmd+l" = "send_text all \\x02l";
      "cmd+t" = "send_text all \\x02c";
      "cmd+shift+t" = "send_text all \\x02pw";
    };

    settings = {
      copy_on_select = true;
      cursor_blink_interval = 0;
      cursor_shape = "beam";
      cursor_stop_blinking_after = 0;
      disable_ligatures = "cursor";
      hide_window_decorations = true;
      macos_option_as_alt = true;
      scrollback_lines = -1;
      strip_trailing_spaces = "always";
      startup_session = "./startup.conf";
      allow_remote_control = "socket-only";
      listen_on = "unix:/tmp/kitty";
    };
  };
 git = {
      enable = true;
      lfs.enable = true;

      includes = [
        {
          condition = "gitdir:~/.config/";
          contents = {
            user = {
              email = email;
              # email = builtins.readFile(config.sops.secrets.email.path);
              name = name;
            };
          };
        }
        {
          condition = "gitdir:~/Code/Personal/";
          contents = {
            user = {
              email = email;
              name = name;
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
        # "devenv.yaml"
        # "devenv.nix"
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

  ssh = {
    enable = true;
    includes = [
      (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
        "/home/${user}/.ssh/config_external"
      )
      (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
        "/Users/${user}/.ssh/config_external"
      )
    ];
    matchBlocks = {
      "github.com" = {
        identitiesOnly = true;
        identityFile = [
          (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
            "/home/${user}/.ssh/id_github"
          )
          (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
            "/Users/${user}/.ssh/id_github"
          )
        ];
      };
    };
  };
  direnv = {
    enable = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
    nix-direnv.enable = true;
  };
  fzf = {
    enable = true;
    enableZshIntegration = true;
  };
  rbenv = {
    enable = true;
    enableZshIntegration = true;
  };
  jq = {
    enable = true;
  };
  zoxide = {
    enable = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
  };
  atuin = {
    enable = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
  };
  ripgrep = {
    enable = true;
    arguments = [
      "--iglob=!.git"
    ];
  };
  eza = {
    enable = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
    git = true;
    icons = "auto";
    extraOptions = [
      "--group-directories-first"
      "--header"
    ];
  };
  fd = {
    enable = true;
    ignores = [
      "*.bak"
      ".git/"
      "node_modules/"
      "vendor/"
    ];
  };
  pyenv = {
    enable = true;
    enableZshIntegration = true;
  };
  yazi = {
    enable = true;
    enableZshIntegration = true;
    keymap = {

    };
  };
  # aerc = {
  #   enable = true;
  # };
  nushell = {
    enable = true;
  };
}
