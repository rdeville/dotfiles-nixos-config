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
  awesomerc = {
    enable = lib.mkForce false;
  };

  sops = {
    age = {
      inherit keyFile;
    };
    defaultSopsFile = ./secrets.enc.yaml;
    secrets = {
      "spotify-client-id" = {};
    };
  };

  hm = {
    inherit username;
    inherit (base) hostName system isGui isMain isDarwin;

    nixpkgs = {
      allowUnfree = true;
    };

    flavors = {
      _core =
        default.flavors._core
        // {
          git =
            default.flavors._core.git
            // {
              pro = {
                condition = "gitdir:/Users/romaindeville/git/github.com/dougs-compta/";
                contents = {
                  commit = {
                    gpgSign = false;
                  };
                  push = {
                    gpgSign = "if-asked";
                  };
                  tag = {
                    forceSignAnnotated = true;
                    gpgSign = false;
                  };
                  user = {
                    name = "Romain Deville";
                    email = "romain.deville@dougs.fr";
                  };
                };
              };
            };
          fastfetch = {
            logo = {
              source = ../../../assets/fastfetch_logos/dougs.txt;
              color = {
                "1" = "light_blue";
              };
            };
          };
        };
      _accounts = {
        enable = base.isMain;
      };
      _gui = {
        enable = base.isGui;
      };
      _packages = {
        enable = true;
        pkgs = with pkgs; [
          viddy
          kind
          ghostscript
          (google-cloud-sdk.withExtraComponents [
            google-cloud-sdk.components.gke-gcloud-auth-plugin
          ])
          google-cloud-sql-proxy
          ssh-to-age
          terragrunt
          vaultwarden
          yubikey-manager.out
        ];
      };
      gh = {
        enable = true;
      };
      kubernetes-client = {
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
      };
      terraform = {
        enable = true;
      };
    };
  };
}
