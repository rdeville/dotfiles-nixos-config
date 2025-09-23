{
  config,
  lib,
  ...
}: let
  user = config.hm.username;
  keyFile = "${config.xdg.cacheHome}/.age.key";
in {
  sops = {
    age = {
      inherit keyFile;
    };
  };

  programs = {
    home-manager = {
      enable = true;
    };
  };

  hm = {
    username = builtins.baseNameOf ./.;
    flavors = {
      _core = {
        fastfetch.enable = false;
        git.enable = false;
        gpg.enable = false;
        home-manager.enable = false;
        lazygit.enable = false;
        mr.enable = false;
      };

      ssh-client = lib.mkIf config.hm.isMain (let
        userKey = "${user}-${config.hm.hostName}.pub";
      in {
        matchBlocks =
          {
            "${user}@darth-vader" = {
              user = user;
              hostname = "romaindeville.fr";
              identitiesOnly = true;
              host = "darth-vader";
              identityFile = [
                "${config.home.homeDirectory}/.ssh/pubkeys/${userKey}"
              ];
            };
            "${user}@darth-plagueis" = {
              user = user;
              hostname = "romaindeville.ovh";
              identitiesOnly = true;
              host = "darth-plagueis";
              identityFile = [
                "${config.home.homeDirectory}/.ssh/pubkeys/${userKey}"
              ];
            };
          }
          // (builtins.foldl' (acc: host: let
            key = "azathoth-${config.hm.hostName}.pub";
          in
            {
              "${user}@${host}" = {
                inherit user host;
                hostname = "${host}.tekunix.private";
                identitiesOnly = true;
                identityFile = [
                  "${config.home.homeDirectory}/.ssh/pubkeys/${key}"
                ];
              };
            }
            // acc) {}
          lib.getValidHosts);
        file = builtins.foldl' (acc: host: let
          key = "${user}-${config.hm.hostName}.pub";
        in
          {
            ".ssh/pubkeys/${key}" = {
              source = ../../../${config.hm.hostName}/users/${user}/_keys/${key};
            };
          }
          // acc) {}
        lib.getValidHosts;
      });

      tmux.enable = true;
    };
  };
}
