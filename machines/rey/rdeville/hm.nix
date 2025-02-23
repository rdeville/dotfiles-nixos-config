{
  config,
  pkgs,
  lib,
  ...
}: let
  username = builtins.baseNameOf ./.;
  base = import ../base.nix;
  default = import ../../default.nix {inherit username;};
in {
  hm = {
    inherit username;
    inherit (base) hostName system isMain;
    wrapGL = false;

    userAccounts = [
      "contact@romaindeville.fr"
      "contact@romaindeville.ovh"
    ];

    flavors = {
      inherit (default.flavors) _core;

      _accounts = {
        enable = base.isMain;
      };

      _gui = {
        enable = base.isGui;
        wayland = {
          hyprspace = {
            enable = false;
          };
        };
      };

      audio = {
        enable = true;
      };

      bluetooth = {
        enable = true;
      };

      discord = {
        enable = true;
      };

      gh = {
        enable = true;
      };

      glab = {
        enable = true;
      };

      kubernetes-client = {
        enable = true;
      };

      latex = {
        enable = true;
      };

      nextcloud-client = {
        enable = true;
      };

      opentofu = {
        enable = true;
      };

      spotify-player = {
        enable = true;
        client_id_command = lib.strings.concatStringsSep " " [
          "${pkgs.coreutils}/bin/cat"
          "${config.xdg.configHome}/sops-nix/secrets/spotify-client-id"
        ];
      };

      ssh-client = {
        enable = true;
        hosts = {
          "darth-plagueis" = {
            domain = "romaindeville.ovh";
            users = {
              "rdeville" = ../../darth-plagueis/rdeville/keys/rdeville-darth-plagueis.pub;
            };
          };
          "darth-maul" = {
            domain = "darth-maul.local";
            users = {
              "rdeville" = ../../darth-maul/rdeville/keys/rdeville-darth-maul.pub;
            };
          };
        };
      };

      terraform = {
        enable = true;
      };

      terragrunt = {
        enable = true;
      };
    };
  };
}
