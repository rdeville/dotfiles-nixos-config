{
  config,
  pkgs,
  lib,
  ...
}: let
  username = builtins.baseNameOf ./.;

  base = import ../base.nix;
  default = import ../../default.nix {inherit username;};
  keyFile = "/home/rdeville/.cache/.age.key";
in {
  sops = {
    age = {
      inherit keyFile;
    };
    defaultSopsFile = ./secrets.enc.yaml;
    secrets = {
      "spotify-client-id" = {
        sopsFile = ../../../../common_secrets/spotify.enc.yaml;
      };
    };
  };

  nixpkgs = {
    config = {
      allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) [
          "nvidia-x11"
          "discord"
        ];
    };
  };

  home = {
    packages = with pkgs; [
      discord
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

  hm = {
    inherit username;
    inherit (base) hostName system isGui isMain;
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
      };
      audio = {
        enable = true;
      };
      bluetooth = {
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
