{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../../_templates/_users/rdeville/server.nix
    ../../_templates/_users/rdeville/gui.nix
    ../../_templates/_users/rdeville/main.nix
  ];

  sops = {
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
          "slack"
          "terraform"
          "zsh-abbr"
        ];
    };
  };

  programs = {
    kitty = {
      settings = {
        macos_option_as_alt = "left";
      };
    };
  };

  home = {
    packages = with pkgs; [
      kind
      (google-cloud-sdk.withExtraComponents [
        google-cloud-sdk.components.gke-gcloud-auth-plugin
      ])
      google-cloud-sql-proxy
      vaultwarden
    ];
  };

  awesomerc = {
    enable = lib.mkForce false;
  };

  hm = {
    username = lib.mkForce "romaindeville"; # lib.mkForce (builtins.baseNameOf ./.);
    system = "aarch64-darwin";
    hostName = builtins.baseNameOf ../.;
    isGui = true;
    isMain = true;
    isDarwin = true;
    isWork = true;

    userAccounts = [
      # "contact@romaindeville.fr"
      "romain.deville@dougs.fr"
    ];

    flavors = {
      _core = {
        git = {
          profiles = {
            pro = {
              condition = "gitdir:${config.home.homeDirectory}/git/github.com/dougs-compta/";
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
        };
        fastfetch = {
          logo = lib.mkForce {
            source = ../../../home-manager/assets/fastfetch_logos/dougs.txt;
            color = {
              "1" = "light_blue";
            };
          };
        };
      };

      _accounts = {
        enable = true;
      };

      audio = {
        enable = lib.mkForce false;
      };

      bluetooth = {
        enable = lib.mkForce false;
      };

      discord = {
        enable = lib.mkForce false;
      };

      latex = {
        enable = lib.mkForce false;
      };

      nextcloud-client = {
        enable = lib.mkForce false;
      };
    };
  };
}
