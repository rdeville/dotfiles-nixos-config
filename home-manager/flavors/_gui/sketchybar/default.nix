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
    programs = {
      sketchybar = {
        enable = true;
      };
    };
  };
}
