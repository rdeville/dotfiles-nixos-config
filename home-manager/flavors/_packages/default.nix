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
          enable = lib.mkDefaultEnabledOption ''
            Install ${name} Home-Manager flavor.
          '';
          pkgs = lib.mkOption {
            type = lib.types.listOf lib.types.package;
            description = "List of nixpkgs to install.";
            default = [];
          };
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = cfg.pkgs;
    };
  };
}
