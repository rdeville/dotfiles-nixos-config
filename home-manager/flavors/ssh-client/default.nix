{
  config,
  lib,
  ...
}: let
  name = "ssh-client";
  cfg = config.hm.flavors.${name};

  mkIdentityFile = hostname: user: let
    pubkeyDir = ".ssh/pubkeys";
    identityFilename = cfg.hosts.${hostname}.users.${user};
  in {
    filename = "${user}-${hostname}.pub";
    pubkey = identityFilename;
    filepath = "${pubkeyDir}/${builtins.baseNameOf identityFilename}";
  };

  file = builtins.listToAttrs (
    builtins.concatLists (
      builtins.map (
        hostname:
          builtins.map (user: let
            userCfg = mkIdentityFile hostname user;
          in {
            name = userCfg.filepath;
            value = {
              enable = true;
              source = userCfg.pubkey;
            };
          }) (builtins.attrNames cfg.hosts.${hostname}.users)
      ) (builtins.attrNames cfg.hosts)
    )
  );

  matchBlocks = builtins.listToAttrs (builtins.concatLists (
    builtins.map (
      hostname:
        builtins.map (
          user: let
            userCfg = mkIdentityFile hostname user;
            name = "${user}@${hostname}";
          in {
            inherit name;
            value = {
              host = name;
              hostname = cfg.hosts.${hostname}.domain;
              user = user;
              identitiesOnly = true;
              identityFile = "${userCfg.filepath}";
            };
          }
        ) (builtins.attrNames cfg.hosts.${hostname}.users)
    )
    (builtins.attrNames cfg.hosts)
  ));
in {
  options = {
    hm = {
      flavors = {
        ${name} = {
          hosts = lib.mkOption {
            type = lib.types.attrsOf (lib.types.submodule {
              options = {
                domain = lib.mkOption {
                  type = lib.types.str;
                  description = "Domain associated to the hosts";
                };
                users = lib.mkOption {
                  type = lib.types.attrsOf lib.types.path;
                  description = "List of ssh users with they pubkey";
                };
              };
            });
            default = {};
            description = "Set of hosts description for ssh-client";
          };
        };
      };
    };
  };
  config = lib.mkIf cfg.enable {
    home = {
      inherit file;
    };

    programs = {
      ssh = {
        inherit matchBlocks;
      };
    };
  };
}
