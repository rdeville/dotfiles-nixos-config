{...}: let
  os = (import ../default.nix {}).os;

  username = "root";
in {
  extraConfig = {};

  hm = {
    inherit username;
    inherit (os) isGui isMain hostname;
    presets = {
      common = {
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
  };
}
