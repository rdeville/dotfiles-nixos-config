{
  config,
  lib,
  ...
}: let
  name = builtins.baseNameOf ./.;
  cfg = config.hm.flavors.${name};
in {
  options = {
    hm = {
      flavors = {
        ${name} = let
          matchBlockModule = lib.types.submodule {
            options = {
              host = lib.mkOption {
                type = lib.types.nullOr lib.types.str;
                default = null;
                example = "*.example.org";
                description = ''
                  `Host` pattern used by this conditional block.
                '';
              };

              port = lib.mkOption {
                type = lib.types.nullOr lib.types.port;
                default = null;
                description = "Specifies port number to connect on remote host.";
              };

              forwardAgent = lib.mkOption {
                default = cfg.forwardAgent;
                type = lib.types.nullOr lib.types.bool;
                description = ''
                  Whether the connection to the authentication agent (if any)
                  will be forwarded to the remote machine.
                '';
              };

              identitiesOnly = lib.mkOption {
                type = lib.types.bool;
                default = false;
                description = ''
                  Specifies that ssh should only use the authentication
                  identity explicitly configured in the
                  {file}`~/.ssh/config` files or passed on the
                  ssh command-line, even if {command}`ssh-agent`
                  offers more identities.
                '';
              };

              identityFile = lib.mkOption {
                type = with lib.types; either (listOf str) (nullOr str);
                default = [];
                apply = p:
                  if p == null
                  then []
                  else if lib.isString p
                  then [p]
                  else p;
                description = ''
                  Specifies files from which the user identity is read.
                  Identities will be tried in the given order.
                '';
              };

              user = lib.mkOption {
                type = lib.types.nullOr lib.types.str;
                default = null;
                description = "Specifies the user to log in as.";
              };

              hostname = lib.mkOption {
                type = lib.types.nullOr lib.types.str;
                default = null;
                description = "Specifies the real host name to log into.";
              };

              serverAliveInterval = lib.mkOption {
                type = lib.types.nullOr lib.types.int;
                default = 30;
                description = "Set timeout in seconds after which response will be requested.";
              };

              serverAliveCountMax = lib.mkOption {
                type = lib.types.nullOr lib.types.ints.positive;
                default = 10;
                description = ''
                  Sets the number of server alive messages which may be sent
                  without SSH receiving any messages back from the server.
                '';
              };

              sendEnv = lib.mkOption {
                type = lib.types.listOf lib.types.str;
                default = [];
                description = ''
                  Environment variables to send from the local host to the
                  server.
                '';
              };

              setEnv = lib.mkOption {
                type = with lib.types;
                  attrsOf (oneOf [
                    str
                    path
                    int
                    float
                  ]);
                default = {};
                description = ''
                  Environment variables and their value to send to the server.
                '';
              };

              extraOptions = lib.mkOption {
                type = lib.types.attrsOf lib.types.str;
                default = {};
                description = "Extra configuration options for the host.";
              };

              hashKnownHosts = lib.mkOption {
                type = lib.types.nullOr lib.types.bool;
                default = cfg.hashKnownHosts;
                description = ''
                   Indicates that
                   {manpage}`ssh(1)`
                   should hash host names and addresses when they are added to
                  the known hosts file.
                '';
              };
            };
          };
        in {
          enable = lib.mkEnableOption "Install ${name} Home-Manager flavor.";

          forwardAgent = lib.mkOption {
            type = lib.types.bool;
            description = ''
              Whether to apply forwardAgent to all server.
            '';
            default = false;
          };

          hashKnownHosts = lib.mkOption {
            type = lib.types.bool;
            description = ''
              Indicates that manpage ssh should hash host names and addresses when
              they are added to the known hosts file.
            '';
            default = true;
          };

          includes = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            description = ''
              List of file globs of ssh config files that should be included via the
              Include directive.
            '';
            default = [
              "$HOME/.ssh/config.d/"
            ];
            example = [
              "$HOME/.ssh/config.d/"
            ];
          };

          matchBlocks = lib.mkOption {
            type = lib.hm.types.dagOf matchBlockModule;
            default = {};
            example = lib.literalExpression ''
              {
                "john.example.com" = {
                  hostname = "example.com";
                  user = "john";
                };
                foo = lib.hm.dag.entryBefore ["john.example.com"] {
                  hostname = "example.com";
                  identityFile = "/home/john/.ssh/foo_rsa";
                };
              };
            '';
            description = ''
              Specify per-host settings. Note, if the order of rules matter
              then use the DAG functions to express the dependencies as
              shown in the example.
            '';
          };

          file = lib.mkOption {
            type = lib.types.attrs;
            description = ''
              Home-Manager files configuration.
            '';
            example = {
              "$HOME/.ssh/pubkeys/key.pub" = {
                enable = true;
                text = ''
                  Public Key Content.
                '';
              };
            };
            default = {};
          };
        };
      };
    };
  };

  config = {
    programs = {
      ssh = {
        enableDefaultConfig = false;
        inherit
          (cfg)
          enable
          includes
          ;
        matchBlocks =
          {
            "*" = {
              forwardAgent = true;
              serverAliveInterval = 0;
              serverAliveCountMax = 3;
              compression = false;
              addKeysToAgent = "no";
              hashKnownHosts = true;
              userKnownHostsFile = "~/.ssh/known_hosts";
              controlMaster = "no";
              controlPath = "~/.ssh/master-%r@%n:%p";
              controlPersist = "no";
            };
          }
          // cfg.matchBlocks;
      };
    };

    services = {
      ssh-agent = {
        enable = cfg.enable && ! config.hm.isDarwin;
      };
    };

    home = {
      inherit (cfg) file;
    };
  };
}
