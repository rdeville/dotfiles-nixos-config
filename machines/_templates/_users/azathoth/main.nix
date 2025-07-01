{
  config,
  lib,
  ...
}: let
  user = config.hm.username;
in {
  hm = {
    flavors = {
      ssh-client = let
        userKey = "${user}-${config.hm.hostName}.pub";
      in {
        enable = true;
        matchBlocks =
          {
            "${user}@darth-vader" = {
              inherit user;
              hostname = "romaindeville.fr";
              identitiesOnly = true;
              host = "darth-vader";
              identityFile = [
                "${config.home.homeDirectory}/.ssh/pubkeys/${userKey}"
              ];
            };
            "${user}@darth-plagueis" = {
              inherit user;
              hostname = "romaindeville.ovh";
              identitiesOnly = true;
              host = "darth-plagueis";
              identityFile = [
                "${config.home.homeDirectory}/.ssh/pubkeys/${userKey}"
              ];
            };
          }
          // (builtins.foldl' (acc: host:
            {
              "${user}@${host}" = {
                inherit user host;
                hostname = "${host}.tekunix.private";
                identitiesOnly = true;
                identityFile = [
                  "${config.home.homeDirectory}/.ssh/pubkeys/${userKey}"
                ];
              };
            }
            // acc) {}
          lib.getValidHosts);
        file = {
          ".ssh/pubkeys/${userKey}" = {
            source = ../../../${config.hm.hostName}/${user}/_keys/${userKey};
          };
        };
      };
    };
  };
}
