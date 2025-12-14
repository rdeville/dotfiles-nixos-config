{
  lib,
  config,
  ...
}: let
  name = builtins.baseNameOf ../.;
  subname = builtins.baseNameOf ./.;
  clr = config.colors.material;
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

            active_color = lib.mkOption {
              type = lib.types.str;
              description = ''
                Sets the border color for the focused window (format: 0xAARRGGBB)
              '';
              default = "0xEE${lib.toUpper clr.str.cyan_A400}";
            };

            inactive_color = lib.mkOption {
              type = lib.types.str;
              description = ''
                Sets the border color for all windows not in focus (format:
                0xAARRGGBB)
              '';
              default = "0xAA${lib.toUpper clr.str.grey_900}";
            };

            background_color = lib.mkOption {
              type = lib.types.str;
              description = ''
                Sets the background fill color for all windows (only 0xAARRGGBB
                arguments supported)
              '';
              default = "0xFFFFFF";
            };

            blur_radius = lib.mkOption {
              type = lib.types.float;
              description = ''
                Sets the blur radius applied to the borders or backgrounds with
                transparency
              '';
              default = 0.0;
            };

            hidpi = lib.mkOption {
              type = lib.types.enum ["on" "off"];
              description = ''
                If set to on, the border will be drawn with retina resolution
              '';
              default = "on";
            };

            order = lib.mkOption {
              type = lib.types.enum [
                "above"
                "below"
              ];
              description = ''
                Specifies whether borders should be drawn above or below windows
              '';
              default = "below";
            };

            style = lib.mkOption {
              type = lib.types.enum [
                "square"
                "round"
              ];
              description = ''
                Specifies the style of the border (either round or square)
              '';
              default = "round";
            };

            width = lib.mkOption {
              type = lib.types.float;
              description = ''Determines the width of the border'';
              default = 5.0;
            };
          };
        };
      };
    };
  };
}
