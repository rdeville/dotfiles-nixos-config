{
  config,
  pkgs,
  lib,
  ...
}: let
  name = builtins.baseNameOf ./.;
  subname = "keynav";
  cfg = config.hm.flavors.${name}.${subname};
in {
  options = {
    hm = {
      flavors = {
        ${name} = {
          ${subname} = {
            enable =
              lib.mkDependEnabledOption ''
                Install ${name}.${subname} Home-Manager flavor.
              ''
              config.hm.flavors.${name}.enable;
          };
        };
      };
    };
  };

  config = lib.mkIf (cfg.enable && (! config.hm.isDarwin)) {
    home = {
      packages = with pkgs; [
        keynav
      ];
    };

    services = {
      keynav = {
        enable = true;
      };
    };
  };
}
