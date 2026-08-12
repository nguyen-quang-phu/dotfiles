_:
[
  # ---------------------------------------------------------------------------
  # Shell & terminal
  # ---------------------------------------------------------------------------
  "starship"
  "tmux"
  "tpack"
  "sesh"
  "zsh-autosuggestions"
  "zsh-syntax-highlighting"
  # "pam-reattach"

  # ---------------------------------------------------------------------------
  # Core CLI utilities
  # ---------------------------------------------------------------------------
  "ripgrep"
  "fd"
  "bat"
  "zoxide"
  "yazi"
  "television"
  "coreutils"
  "gnu-sed"
  "sevenzip"
  "cesarferreira/tap/rip" # safer rm
  "mole" # Deep clean and optimize your Mac.
  "killport"
  # "ast-grep"
  # "bottom"
  # "btop"
  # "lnav"
  # "chafa"
  # "aria2"  # download tool
  # "wrk"

  # ---------------------------------------------------------------------------
  # Data / config formats
  # ---------------------------------------------------------------------------
  "yq"
  "jq"
  # "taplo"

  # ---------------------------------------------------------------------------
  # Editor
  # ---------------------------------------------------------------------------
  "neovim"
  # "opencode"

  # ---------------------------------------------------------------------------
  # Git & version control
  # ---------------------------------------------------------------------------
  "gh"
  "git-lfs"
  "lazygit"
  "lefthook"
  "diffnav"
  "worktrunk"
  "witr"
  # "git-town"
  # "withgraphite/tap/graphite"
  # "gitmoji"
  # "commitizen"
  # "act"
  # "acli"

  # ---------------------------------------------------------------------------
  # Toolchains & environment management
  # ---------------------------------------------------------------------------
  "mise"
  "direnv"
  "fnm"
  "deno"
  # "rustup"
  # "rust"
  # "pipx"

  # ---------------------------------------------------------------------------
  # Build & project tooling
  # ---------------------------------------------------------------------------
  "just"
  "copier"
  "chezmoi"
  "dotenvx/brew/dotenvx"
  "bufbuild/buf/buf"
  # "grpcurl"
  # "resterm"

  # ---------------------------------------------------------------------------
  # Containers & services
  # ---------------------------------------------------------------------------
  "whalebrew"
  "cloudflared"
  "nginx"
  # "docker"
  # "podman"
  # "localstack/tap/localstack-cli"
  # "dopplerhq/cli/doppler"

  # ---------------------------------------------------------------------------
  # Media
  # ---------------------------------------------------------------------------
  "ffmpeg"
  "imagemagick"
  "media-info"
  "poppler" # don't delete
  "resvg"
  "portaudio"
  "LargeModGames/spotatui/spotatui"

  # ---------------------------------------------------------------------------
  # Libraries (ruby on rails / native build deps)
  # ---------------------------------------------------------------------------
  "libyaml"
  "openssl@3"
  "gmp"
  "libffi"
  "readline"
  "libiconv"

  # ---------------------------------------------------------------------------
  # AI / agents
  # ---------------------------------------------------------------------------
  # "gemini-cli"
  # "agent-browser"
  # "reddix"

  # ---------------------------------------------------------------------------
  # Databases & data stores
  # ---------------------------------------------------------------------------
  {
    name = "redis";
    restart_service = true;
    link = true;
  }
  # {
  #   name = "meilisearch";
  #   restart_service = true;
  #   # link = true;
  # }
  # {
  #   name = "mongodb-community@8.0";
  #   restart_service = true;
  #   link = false;
  #   # conflicts_with = ["mysql"];
  # }
  # {
  #   name = "mysql@8.0";
  #   restart_service = true;
  #   link = true;
  #   conflicts_with = ["mysql"];
  # }
  # {
  #   name = "postgresql@16";
  #   restart_service = true;
  #   link = true;
  #   conflicts_with = ["postgresql"];
  # }
  # "mongocli"
  # "mongosh"
  # "mongodb/brew/mongodb-database-tools"
]
