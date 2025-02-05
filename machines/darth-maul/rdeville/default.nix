{
  config,
  pkgs,
  lib,
  ...
}: let
  username = builtins.baseNameOf ./.;

  base = import ../base.nix;
  default = import ../../default.nix {inherit username;};
  keyFile = "${config.xdg.cacheHome}/.age.key";
in {
  sops = {
    age = {
      inherit keyFile;
    };
    defaultSopsFile = ./secrets.enc.yaml;
    secrets = {
      "spotify-client-id" = {
        sopsFile = ../../../common_secrets/spotify.enc.yaml;
      };
    };
  };

  nixpkgs = {
    config = {
      allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) [
          "discord"
        ];
    };
  };

  xdg = {
    configFile = {
      "discord/settings.json" = {
        text = builtins.toJSON {
          SKIP_HOST_UPDATE = true;
        };
      };
    };
  };

  home = {
    shellAliases = {
      docker = "sudo docker";
    };
    packages = with pkgs; [
      discord
      inkscape
      hclfmt
      libreoffice
      luarocks-nix
      gimp
      ghostscript
      go
      (
        google-cloud-sdk.withExtraComponents [
          google-cloud-sdk.components.gke-gcloud-auth-plugin
        ]
      )
      google-cloud-sql-proxy
      signal-desktop
      ssh-to-age
      texliveFull
      terraform-docs
      terragrunt
      viddy
      whatsapp-for-linux
      yubikey-manager.out
    ];
  };

  hm = {
    inherit username;
    inherit (base) hostName system isMain;

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
          hyprexpo = {
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
        enable = false;
      };
    };
  };
}
