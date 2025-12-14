{
  config,
  lib,
  ...
}: let
  name = builtins.baseNameOf ../.;
  subname = builtins.baseNameOf ./.;
  cfg = config.hm.flavors.${name}.${subname};
in {
  imports = [
    ./options.nix
  ];

  config = lib.mkIf (cfg.enable && config.hm.isDarwin) {
    services = {
      jankyborders = {
        enable = true;
        settings = {
          inherit
            (cfg)
            active_color
            inactive_color
            background_color
            blur_radius
            hidpi
            order
            style
            width
            ;
        };
      };
    };
  };
}
