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
      gc = {
        automatic = true;
        options = "--delete-older-than 7d";
        interval = [
          {
            Hour = 18;
            Minute = 00;
            Weekday = 5;
          }
        ];
      };

      package = pkgs.nixVersions.latest;

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
