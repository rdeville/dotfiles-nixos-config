{
  config,
  lib,
  ...
}: let
  pubKey = {
    dst = "code+public@romaindeville.fr.pub";
    src = "code-public-romaindeville.fr.pub";
  };
  hosts = [
    {
      name = "github";
      hostname = "github.com";
    }
    {
      name = "framagit";
      hostname = "framagit.org";
    }
    {
      name = "gitlab";
      hostname = "gitlab.org";
    }
  ];
in {
  nixpkgs = {
    config = {
      allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) (
          if config.hm.isMain
          then [
            "discord"
            "terraform"
            "slack"
            "vscode"
            "vscode-extension-ms-vsliveshare-vsliveshare"
            "zsh-abbr"
          ]
          else [
            "zsh-abbr"
          ]
        );
    };
  };

  hm = {
    username = builtins.baseNameOf ./.;
    flavors = {
      _core = {
        fastfetch = {
          logo = {
            source = ../../../../home-manager/assets/fastfetch_logos/anarchy.txt;
            color = {
              "1" = "bright_red";
              "2" = "red";
              "3" = "light_red";
            };
          };
        };

        git = {
          profiles = {
            perso = {
              condition = "gitdir:/";
              contents = {
                commit = {
                  gpgSign = true;
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
      };

      ssh-client = {
        enable = true;
        matchBlocks = builtins.foldl' (acc: elem:
          {
            "${elem.name}" = {
              hostname = elem.hostname;
              identitiesOnly = true;
              host = elem.name;
              identityFile = [
                "$HOME/.ssh/pubkeys/${pubKey.dst}"
              ];
            };
          }
          // acc) {}
        hosts;
        file = {
          ".ssh/pubkeys/${pubKey.dst}" = {
            source = ../../../../home-manager/assets/pubkeys/${pubKey.src};
          };
        };
      };
    };
  };
}
