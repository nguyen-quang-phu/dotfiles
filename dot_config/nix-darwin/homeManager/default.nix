{
  inputs,
  ...
}: {
  # import sub modules
  imports = [
   ./neovim
    ./cli.nix
    ./git.nix
    ./age
    ./programs
    # zsh is managed by chezmoi (~/.zshrc), not home-manager
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.

  home = {
    #inherit username;
    # homeDirectory = "/Users/dev/";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "26.05";
    file = {};

    shellAliases = {
      "t"="tmux new-session -A -s keynold";
      "..." = "cd ../..";
      "darwin-build" = "just -f ~/.config/nix-darwin/justfile build";
      "edit-secrets" = "just -f ~/.config/nix-darwin/justfile edit-secrets";
      "darwin-update" = "just -f ~/.config/nix-darwin/justfile update";
      "ze" = "zellij";
      "zed" = "ze a -c default";
      "justg" = "just -g";
      "asvim" = "NVIM_APPNAME=astro_nvim nvim";
      # "docker" = "podman";
    };
  };
  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;
  };
}
