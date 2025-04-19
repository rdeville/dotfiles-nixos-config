{
  config,
  pkgs,
  lib,
  ...
}: let
  keyFile = "${config.xdg.cacheHome}/.age.key";
in {
  imports = [
    ../../_templates/_users/rdeville/server.nix
    ../../_templates/_users/rdeville/gui.nix
  ];

  sops = {
    age = {
      inherit keyFile;
    };
    secrets = {
      "spotify-client-id" = {
        sopsFile = ../../../common_secrets/spotify.enc.yaml;
      };
    };
  };

  hm = {
    flavors = {
      bluetooth = {
        enable = true;
      };

      spotify-player = {
        enable = true;
        client_id_command = lib.strings.concatStringsSep " " [
          "${pkgs.coreutils}/bin/cat"
          "${config.xdg.configHome}/sops-nix/secrets/spotify-client-id"
        ];
      };
    };
  };
}
