{config, ...}: let
  yubicoIds = [
    "30105708"
    "30105737"
  ];
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
  sops = {
    secrets = builtins.foldl' (acc: elem:
      {
        "yubico-${elem}-challenge" = {
          sopsFile = ../../../../common/secrets/yubico-${elem}.enc.yaml;
        };
      }
      // acc) {}
    yubicoIds;
    templates = builtins.foldl' (acc: elem:
      {
        "yubico-${elem}-challenge" = {
          content = config.sops.placeholder."yubico-${elem}-challenge";
          path = "/home/${config.hm.username}/.yubico/challenge-${elem}";
        };
      }
      // acc) {}
    yubicoIds;
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
                "${config.home.homeDirectory}/.ssh/pubkeys/${pubKey.dst}"
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
