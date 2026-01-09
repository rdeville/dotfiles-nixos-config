{lib, ...}: {
  options = {
    os = {
      users = {
        users = lib.mkOption {
          description = "Configure NixOS users.";
          default = {};
          type = lib.types.attrsOf (
            lib.types.submodule {
              options = {
                isPrimary = lib.mkEnableOption "Set user as primary";
                isSudo = lib.mkEnableOption "Enable sudo group for the user";

                shell = lib.mkOption {
                  type = lib.types.str;
                  description = "The shell for the user.";
                  default = "zsh";
                };

                home = lib.mkOption {
                  type = lib.types.str;
                  description = ''
                    The user's home directory. This defaults to null.
                    When this is set to null, if the user has not been created yet, they will be created with the home directory /var/empty to match the old default.
                  '';
                };

                openssh = {
                  authorizedKeys = {
                    keyFiles = lib.mkOption {
                      type = lib.types.listOf lib.types.path;
                      description = ''
                        Keyfiles to authorized keys to connect to this user
                      '';
                      default = [];
                    };
                  };
                };

                extraGroups = lib.mkOption {
                  type = lib.types.listOf lib.types.str;
                  description = "List of extra group for the user";
                  default = [];
                };
              };
            }
          );
        };
      };
    };
  };
}
