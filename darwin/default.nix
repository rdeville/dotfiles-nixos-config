{
  config,
  pkgs,
  ...
}: let
  cfg = config.os;
in {
  imports = [
    ./flavors
    ./users
    ./options.nix
  ];

  config = {
    system = {
      inherit (cfg) stateVersion;
    };

    networking = {
      inherit (cfg) hostName;
    };

    nix = {
      package = pkgs.nixVersions.latest;

      gc = {
        automatic = true;
        options = "--delete-older-than 30d";
        interval = [
          {
            Hour = 18;
            Minute = 00;
            Weekday = 5;
          }
        ];
      };

      optimise = {
        automatic = true;
        interval = [
          {
            Hour = 18;
            Minute = 15;
            Weekday = 5;
          }
        ];
      };

      settings = {
        accept-flake-config = true;
        extra-experimental-features = [
          "flakes"
          "nix-command"
          "auto-allocate-uids"
        ];
        keep-outputs = true;
        keep-derivations = true;
        show-trace = true;
        trusted-users = [
          "root"
          "@wheel"
          "@sudo"
        ];
      };
    };

    nixpkgs = {
      hostPlatform = cfg.system;
    };

    time = {
      inherit (cfg) timeZone;
    };

    homebrew = {
      enable = true;
      caskArgs = {
        require_sha = true;
      };
    };
  };
}
