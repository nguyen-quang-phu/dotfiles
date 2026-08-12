{
  pkgs,
  lib,
  ...
}: {
  nix-homebrew = {
    # Install Homebrew under the default prefix
    enable = true;

    # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
    enableRosetta = true;

    # User owning the Homebrew prefix
    user = "dev";

    # Automatically migrate existing Homebrew installations
    autoMigrate = true;
  };
  homebrew = {
    enable = true;
    global.brewfile = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      # 'zap': uninstalls all formulae(and related files) not listed here.
      cleanup = "zap";
    };
    caskArgs = {
      # no_quarantine = true;
      require_sha = false;
    };

    # Homebrew 6.0.0 enabled HOMEBREW_REQUIRE_TAP_TRUST by default, which refuses to
    # load formulae/casks from non-official taps unless trusted. `trusted = true` adds
    # `trusted: true` to each tap's Brewfile line so activation can install from them.
    # This is required for bare formula names (e.g. "spotatui", "rip") which resolve
    # through the tap; fully-qualified brews get `trusted: true` on their own by default.
    taps = [
      # { name = "anomalyco/tap"; trusted = true; }
      # { name = "LargeModGames/spotatui"; trusted = true; }
      # { name = "chase/tap"; trusted = true; }
      # { name = "FelixKratz/formulae"; trusted = true; }
      # { name = "netmute/tap"; trusted = true; }
      # { name = "mongodb/brew"; trusted = true; }
      # { name = "padok-team/tap"; trusted = true; }
      # { name = "nikitabobko/tap"; trusted = true; }
      # { name = "atlassian/homebrew-acli"; trusted = true; }
      # { name = "cesarferreira/tap"; trusted = true; }
      # { name = "manaflow-ai/cmux"; trusted = true; }
    ];

    # `brew install`
    # TODO Feel free to add your favorite apps here.
    brews = pkgs.callPackage ./brews.nix {};

    # `brew install --cask`
    # TODO Feel free to add your favorite apps here.
    casks = pkgs.callPackage ./casks.nix {};

    masApps = {
      # "Xcode" = 497799835;
      # "DropOver" = 1355679052;
      # "Amphetamine" = 937984704;
      # "Bitwarden" = 1352778147;
      # "Trello" = 1278508951;
    };
  };
}
