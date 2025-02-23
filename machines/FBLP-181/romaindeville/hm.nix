{
  config,
  lib,
  pkgs,
  ...
}: let
  username = builtins.baseNameOf ./.;

  default = import ../../default.nix {inherit username;};

  system = "aarch64-darwin";
  hostName = builtins.baseNameOf ./.;
  isGui = true;
  isMain = true;
  isDarwin = true;
  isWork = true;
in {
  hm = {
    inherit username hostName system isMain isDarwin isWork;

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
              source = ../../../assets/fastfetch_logos/dougs.txt;
              color = {
                "1" = "light_blue";
              };
            };
          };
        };

      _accounts = {
        enable = isMain;
      };

      _gui = {
        enable = isGui;
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
