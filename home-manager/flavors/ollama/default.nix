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
        ${name} = {
          enable = lib.mkEnableOption "Install ${name} Home-Manager flavor.";
          acceleration = lib.mkOption {
            type = lib.types.either lib.types.bool lib.types.str;
            description = ''
              What interface to use for hardware acceleration, see
              Home-Manager for more details.
            '';
            default = false;
          };
        };
      };
    };
  };

  config = {
    services = {
      ollama = {
        inherit
          (cfg)
          enable
          acceleration
          ;
      };
    };
  };
}
