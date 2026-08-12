{
pkgs,
config,
...
}: {
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;
      allowBroken = true;
    };
  };

  nix = {
    settings = {
      trusted-users = ["dev"];
      # enable flakes globally
      experimental-features = ["nix-command" "flakes"];

      builders-use-substitutes = true;
      warn-dirty = false;
    };
    extraOptions = ''
        extra-substituters = https://devenv.cachix.org
        extra-trusted-public-keys = devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=
    '';
    optimise.automatic = true;

    gc = {
      automatic = true;
      interval = {
        Weekday = 0;
        Hour = 2;
        Minute = 0;
      };
      options = "--delete-older-than 30d";
    };
  };
  security.pam.services.sudo_local = {
    touchIdAuth = true;
    # Touch ID for sudo inside tmux/screen: reattaches to the GUI bootstrap session.
    reattach = true;
  };

  # Auto upgrade nix package and the daemon service.
  nix.package = pkgs.nix;
}
