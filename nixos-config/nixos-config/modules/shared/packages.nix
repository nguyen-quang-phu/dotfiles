{ pkgs }:

with pkgs; [
  awsebcli
  clipboard-jh
  codespell
  devenv
  devpod
  glab
  # graphviz
  just
  lazysql
  macchina
  maccy
  mycli
  nap
  ngrok
  nix-prefetch-scripts
  pgcli
  postman
  # rectangle
  slack
  tldr
  wget
  yaml-language-server
  # nix
  nixd
  nil
  statix

  # lua
  luajitPackages.luacheck

  # rust
  rustup
  # cargo

  #node
  nodePackages.yarn
  nodejs_22

  # go
  go
  comma
  openssl
  gitlab-ci-local
  fnm
  vscode-extensions.xdebug.php-debug
  php81Extensions.xdebug

  # rubyPackages.solargraph
  cachix
  ueberzugpp
  podman
  deadnix
  typos-lsp
  typos
  gitleaks
  killport
  age
  postgis
  rubyPackages.solargraph
  rubocop
  git-crypt
  # bundler
  process-compose
  # neovim
  sops
  gnupg
  # darwin.IOKit
  # kmonad
  goku
  universal-ctags
  docker
  fzf
  # yazi
  # Encryption and security tools
]
