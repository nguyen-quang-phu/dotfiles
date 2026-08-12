{
  description = "Example nix-darwin system flake";

  inputs = {
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    # Optional: Declarative tap management
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix.url = "github:ryantm/agenix";
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    home-manager,
    agenix,
    nix-homebrew,
    homebrew-core,
    homebrew-cask,
    ...
    }: let
      username = "dev";
      system = "aarch64-darwin"; # aarch64-darwin or x86_64-darwin
      hostname = "dev";
      useremail = "nqphu1998" + "@" + "gmail" + "." + "com";
      pkgs = nixpkgs.legacyPackages.${system};
      specialArgs =
        inputs
        // {
          inherit username hostname useremail;
        };
      configuration = {pkgs, ...}: {
        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        environment.systemPackages = with pkgs; [
          vim
          vscode
          agenix.packages.${system}.default
        ];

        # Necessary for using flakes on this system.
        #nix.settings.experimental-features = "nix-command flakes";
        #nixpkgs.config.allowUnfree = true;

        # Enable alternative shell support in nix-darwin.
        # programs.fish.enable = true;

        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 6;

        # The platform the configuration will be used on.
        nixpkgs.hostPlatform = "aarch64-darwin";
      };
    in
      import ./darwin { inherit self nix-darwin home-manager agenix configuration inputs nix-homebrew; };
}
