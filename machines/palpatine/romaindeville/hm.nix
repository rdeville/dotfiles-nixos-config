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

    userAccounts = [];

    flavors = {
      _core =
        default.flavors._core
        // {
          git =
            default.flavors._core.git
            // {
              profiles = lib.mkIf (base ? isWork && base.isWork) {
                pro = {
                  # TODO: @rdeville: Update condition below
                  condition = "gitdir:${config.home.homeDirectory}/git/TODO/";
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
                      # TODO: @rdeville: Update email address below
                      email = "TODO";
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
        enable = false;
      };

      _gui = {
        enable = base.isGui;
        wayland = {
          enable = true;
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
        enable = true;
      };
    };
  };
}
