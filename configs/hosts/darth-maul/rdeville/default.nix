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
  keyFile = "/home/rdeville/.cache/.age.key";
in {
  extraConfig = {
    sops = {
      age = {
        inherit keyFile;
      };
      defaultSopsFile = ./rdeville.enc.yaml;
      secrets = {
        "spotify-client-id" = {};
        "age-key" = {
          path = keyFile;
        };
      };
    };
  };

  hm = {
    inherit username isGui isMain;
    inherit (os) hostName;
    wrapGL = false;
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
      _packages = {
        enable = true;
        pkgs = with pkgs; [
          pcmanfm
          inkscape
          hclfmt
          libreoffice
          gimp
          ghostscript
          google-cloud-sdk
          google-cloud-sql-proxy
          signal-desktop
          texliveFull
          terraform-docs
          terragrunt
          whatsapp-for-linux
        ];
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
      nextcloud-client = {
        enable = true;
      };
      opentofu = {
        enable = true;
      };
      podman = {
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
    };
  };
}
