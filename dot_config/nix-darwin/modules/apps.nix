{
pkgs,
lib,
...
}: {
  ##########################################################################
  #
  #  Install all apps and packages here.
  #
  #  NOTE: Your can find all available options in:
  #    https://daiderd.com/nix-darwin/manual/index.html
  #
  # TODO Fell free to modify this file to fit your needs.
  #
  ##########################################################################

  # Install packages from nix's official package repository.
  #
  # The packages installed here are available to all users, and are reproducible across machines, and are rollbackable.
  # But on macOS, it's less stable than homebrew.
  #
  # Related Discussion: https://discourse.nixos.org/t/darwin-again/29331
  environment.systemPath = ["/opt/homebrew/bin"];
  environment.pathsToLink = ["/Applications"];
  environment.shells = [
    pkgs.zsh
  ];

  environment.systemPackages = with pkgs; [
    # # redis
    # awsebcli
    # sqlite
    # clipboard-jh
    # codespell
    # devenv
    # # devpod
    # glab
    # # graphviz
    # just
    # lazysql
    # # macchina
    # mycli
    # pgcli
    # # ngrok
    # nix-prefetch-scripts
    # postman
    # # rectangle
    # tldr
    # wget
    # yaml-language-server
    # # nix
    # nixd
    # nil
    # statix
    #
    # # lua
    # luajitPackages.luacheck
    #
    # # rust
    # rustup
    #
    # #node
    # # nodePackages.yarn
    # # nodejs_22
    #
    # # go
    # go
    # #comma
    # openssl
    # fnm
    # #vscode-extensions.xdebug.php-debug
    # #php81Extensions.xdebug
    #
    # # rubyPackages.solargraph
    # cachix
    # ueberzugpp
    # podman
    # deadnix
    # typos-lsp
    # typos
    # gitleaks
    # killport
    # age
    # # postgis
    # #rubyPackages.solargraph
    # #rubocop
    # #git-crypt
    # # bundler
    # process-compose
    # # neovim
    # sops
    # gnupg
    # # darwin.IOKit
    # # kmonad
    # #goku
    # universal-ctags
    # docker
    # fzf
    # stow
    # # gcc
    # # bluetui
    # # pulsemixer
    # ffmpeg
    # nginx-language-server
  ];
  # fonts.packages = [] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
  fonts.packages = with pkgs.nerd-fonts; [
    jetbrains-mono
    fira-code
  ];
  system.primaryUser = "dev";
  # TODO To make this work, homebrew need to be installed manually, see https://brew.sh
  #
  # The apps installed by homebrew are not managed by nix, and not reproducible!
  # But on macOS, homebrew has a much larger selection of apps than nixpkgs, especially for GUI apps!

}
