{
  config,
  lib,
  ...
}: let
  name = builtins.baseNameOf ./.;
  cfg = config.hm.flavors.${name};
in {
  imports = builtins.map (item: ./${item}) (lib.importDir ./.);

  options = {
    hm = {
      flavors = {
        ${name} = {
          enable = lib.mkEnableOption "Install ${name} Home-Manager flavor.";

          forwardAgent = lib.mkOption {
            type = lib.types.bool;
            description = ''
              Whether to forwardAgent to the server.
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
            type = lib.types.attrsOf lib.types.attrs;
            description = ''
              MatchBlock object to configure ssh-client.
            '';
            example = {
              "hostname" = {
                hostname = "hostname.tld";
                host = "hostname";
                identitiesOnly = true;
                user = "username";
                identityFile = [
                  "$HOME/.ssh/key"
                ];
              };
            };
            default = {};
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
        inherit
          (cfg)
          enable
          forwardAgent
          hashKnownHosts
          includes
          matchBlocks
          ;
      };
    };

    services = {
      ssh-agent = {
        enable = cfg.enable && ! config.hm.isDarwin;
      };
    };

    home = {
      file = cfg.file;
    };
  };
}
