{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.os;
in {
  imports = [
    ./flavors
    ./users
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
        dates = "weekly";
        options = "--delete-older-than 7d";
      };

      package = pkgs.nixVersions.latest;

      settings = {
        accept-flake-config = true;
        auto-optimise-store = lib.mkDefault true;
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
