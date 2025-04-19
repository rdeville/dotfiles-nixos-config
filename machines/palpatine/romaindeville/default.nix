{
  config,
  pkgs,
  lib,
  ...
}: let
  keyFile = "${config.xdg.cacheHome}/.age.key";

  username = builtins.baseNameOf ./.;

  default = import ../../default.nix {inherit username;};
in {
  imports = [
    ./hm.nix
  ];

  awesomerc = {
    enable = lib.mkForce false;
  };

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
      slack
      ghostscript
      (google-cloud-sdk.withExtraComponents [
        google-cloud-sdk.components.gke-gcloud-auth-plugin
      ])
      google-cloud-sql-proxy
      ssh-to-age
      vaultwarden
      yubikey-manager.out
    ];
  };

  hm = {
    inherit username;
    system = "aarch64-darwin";
    hostName = builtins.baseNameOf ./.;
    isGui = true;
    isMain = true;
    isDarwin = true;
    isWork = true;

    flavors = {
      _core =
        default.flavors._core
        // {
          git = {
            profiles =
              default.flavors._core.git.profiles
              // {
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
            logo = {
              source = ../../../home-manager/assets/fastfetch_logos/dougs.txt;
              color = {
                "1" = "light_blue";
              };
            };
          };
        };

      _gui = {
        enable = true;
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

      terragrunt = {
        enable = true;
      };
    };
  };
}
