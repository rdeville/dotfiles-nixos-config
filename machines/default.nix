{username, ...}: {
  flavors = {
    _core = {
      fastfetch = {
        logo = {
          source = ../assets/fastfetch_logos/anarchy.txt;
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
    };
  };
}
