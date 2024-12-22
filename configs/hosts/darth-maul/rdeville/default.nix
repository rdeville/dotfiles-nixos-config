{
  pkgs,
  lib,
  ...
}: let
  os = (import ../default.nix {}).os;

  username = "rdeville";
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
    inherit username;
    inherit (os) isGui isMain hostname;
    userAccounts = [
      "contact@romaindeville.fr"
      "contact@romaindeville.ovh"
    ];
    presets = {
      common = {
        enable = true;
      };
      gui = {
        enable = true;
      };
      minimal = {
        enable = true;
        git = {
          perso = {
            condition = "gitdir:/";
            contents = {
              commit = {
                gpgSign = true;
              };
              credential = {
                "https://framagit.org" = {
                  inherit username;
                };
                "https://github.com" = {
                  inherit username;
                };
                "https://gitlab.com" = {
                  inherit username;
                };
              };
              push = {
                gpgSign = "if-asked";
              };
              tag = {
                forceSignAnnotated = true;
                gpgSign = true;
              };
              user = {
                name = "Romain Deville";
                email = "code@romaindeville.fr";
                signingKey = "0x700E80E57C25C99A";
              };
            };
          };
        };
      };
      main = {
        enable = true;
      };
    };

    flavors = {
      whatsapp = {
        enable = true;
      };
      terragrunt = {
        enable = true;
      };
      terraform = {
        enable = false;
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
      spotify-player = {
        enable = true;
        client_id_command = lib.strings.concatStrings [
          "${pkgs.coreutils}/bin/cat"
          "/home/rdeville/.config/sops-nix/secrets/spotify-client-id"
        ];
      };
      signal = {
        enable = true;
      };
      podman = {
        enable = true;
      };
      opentofu = {
        enable = true;
      };
      nextcloud-client = {
        enable = true;
      };
      latex = {
        enable = true;
      };
      kubernetes-client = {
        enable = true;
      };
      glab = {
        enable = true;
      };
      gh = {
        enable = true;
      };
      discord = {
        enable = true;
      };
      bluetooth = {
        enable = true;
      };
    };
  };
}
