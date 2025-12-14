{
  lib,
  config,
  ...
}: let
  name = builtins.baseNameOf ../.;
  subname = builtins.baseNameOf ./.;
in {
  options = {
    hm = {
      flavors = {
        ${name} = {
          ${subname} = {
            enable =
              lib.mkDependEnabledOption ''
                Install ${name}.${subname} Darwin flavor.
              ''
              config.hm.flavors.${name}.enable;

            config = lib.mkOption {
              type = lib.types.lines;
              default = "";
              description = ''
                Contents of sketchybar's configuration file. If empty (the default), the configuration file won't be managed.

                See [documentation](https://felixkratz.github.io/SketchyBar/)
                and [example](https://github.com/FelixKratz/SketchyBar/blob/master/sketchybarrc).
              '';
            };

            extraPackages = lib.mkOption {
              type = lib.types.listOf lib.types.package;
              default = [];
              description = ''
                Extra packages to add to PATH.
              '';
            };
          };
        };
      };
    };
  };
}
