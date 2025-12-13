{
  config,
  lib,
  ...
}: let
  name = builtins.baseNameOf ./.;
  cfg = config.os.flavors.${name};
in {
  options = {
    os = {
      flavors = {
        ${name} = {
          enable = lib.mkEnableOption "Install ${name} NixOS flavors.";
          dns = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            description = ''
              The list of dns servers used when resolving domain names.
            '';
            default = [
              "80.67.169.12"
              "80.67.169.40"
              "2001:910:800::12"
              "2001:910:800::40"
            ];
          };
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    networking = {
      inherit (cfg) dns;
    };
  };
}
