{config, ...}: let
  users = {
    rdeville = {
      isSudo = true;
      extraGroups = [
        "ydotool"
      ];
      openssh = {
        authorizedKeys = {
          keyFiles = [
            ../../darth-maul/users/rdeville/_keys/rdeville-darth-maul.pub
            ../../rey/users/rdeville/_keys/rdeville-rey.pub
          ];
        };
      };
    };
    azathoth = {
      isSudo = true;
      extraGroups = [
        "deploy"
      ];
      openssh = {
        authorizedKeys = {
          keyFiles = [
            ../../darth-maul/users/azathoth/_keys/azathoth-darth-maul.pub
            ../../rey/users/azathoth/_keys/azathoth-rey.pub
            ../../kenobi/users/azathoth/_keys/azathoth-kenobi.pub
          ];
        };
      };
    };
    cthulhu = {
      isSudo = true;
      openssh = {
        authorizedKeys = {
          keyFiles = [
            ../../darth-maul/users/cthulhu/_keys/cthulhu-darth-maul.pub
            ../../rey/users/cthulhu/_keys/cthulhu-rey.pub
          ];
        };
      };
    };
    root = {};
  };

  secrets =
    builtins.foldl' (acc: elem:
      {
        "users/${elem}/password" = {
          neededForUsers = true;
        };
      }
      // acc) {} (
      builtins.filter (user: (
        # Ignore users azathoth and cthulhu, no password login
        (builtins.match "test" user != [])
        && (builtins.match "azathoth" user != [])
        && (builtins.match "cthulhu" user != [])
      )) (builtins.attrNames users)
    )
    // {
    };
in {
  config = {
    os = {
      users = {
        inherit users;
      };
    };

    sops = {
      inherit secrets;
    };

    home-manager = {
      users = builtins.foldl' (acc: elem:
        {
          ${elem} = {
            hm = {
              stateVersion = config.os.stateVersion;
            };
            imports =
              if elem == "rdeville"
              then
                if config.os.isMain
                then [
                  ./${elem}/server.nix
                  ./${elem}/gui.nix
                  ./${elem}/main.nix
                ]
                else if config.os.isGui
                then [
                  ./${elem}/server.nix
                  ./${elem}/gui.nix
                ]
                else [
                  ./${elem}/server.nix
                ]
              else [
                ./${elem}/server.nix
              ];
          };
        }
        // acc) {} (builtins.attrNames users);
    };
  };
}
