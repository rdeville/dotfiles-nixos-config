{
  pkgs,
  lib,
  ...
}: let
  username = builtins.baseNameOf ./.;

  os = (import ../default.nix {}).os;
  default = import ../../default.nix {inherit username;};
  isGui =
    if os ? isGui
    then os.isGui
    else false;
  isMain =
    if os ? isMain
    then os.isMain
    else false;
in {
  extraConfig = {
    sops = {
      age = {
        keyFile = "/home/rdeville/.cache/.age.key";
      };
      defaultSopsFile = ./rdeville.enc.yaml;
      secrets = {
        "spotify-client-id" = {
          sopsFile = ./rdeville.enc.yaml;
        };
      };
    };
  };

  hm = {
    inherit username isGui isMain;
    inherit (os) hostname;
    wrapGL = true;
    userAccounts = [
      "contact@romaindeville.fr"
      "contact@romaindeville.ovh"
    ];

    flavors = {
      inherit (default.flavors) _core;
      _accounts = {
        enable = isMain;
      };
      _gui = {
        enable = isGui;
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
      podman = {
        enable = true;
      };
      signal = {
        enable = true;
      };
      spotify-player = {
        enable = true;
        client_id_command = lib.strings.concatStrings [
          "${pkgs.coreutils}/bin/cat"
          "/home/rdeville/.config/sops-nix/secrets/spotify-client-id"
        ];
      };
      ssh-client = {
        enable = true;
        hosts = {
          "darth-vader" = {
            domain = "romaindeville.fr";
            users = {
              "rdeville" = ../../../pubkeys/rdeville-darth-vader.pub;
            };
          };
          "darth-plagueis" = {
            domain = "romaindeville.ovh";
            users = {
              "rdeville" = ../../../pubkeys/rdeville-darth-plagueis.pub;
            };
          };
          "darth-maul" = {
            domain = "darth-maul.local";
            users = {
              "rdeville" = ../../../pubkeys/rdeville-darth-maul.pub;
            };
          };
        };
      };
      terraform = {
        enable = false;
      };
      terragrunt = {
        enable = true;
      };
      whatsapp = {
        enable = true;
      };
    };
  };
}
