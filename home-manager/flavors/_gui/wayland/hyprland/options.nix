{
  config,
  lib,
  ...
}: let
  name = builtins.baseNameOf ../../.;
  subname = builtins.baseNameOf ../.;
  subsubname = builtins.baseNameOf ./.;
in {
  options = {
    hm = {
      flavors = {
        ${name} = {
          ${subname} = {
            ${subsubname} = {
              enable =
                lib.mkDependEnabledOption ''
                  Install ${name}.${subname}.${subsubname} Home-Manager flavor.
                ''
                (
                  config.hm.flavors.${name}.enable
                  && config.hm.flavors.${name}.${subname}.enable
                );

              plugins = lib.mkOption {
                type = with lib.types; listOf (either package path);
                description = ''
                  List of Hyprland default plugins to use.
                  Can either be packages or absolute plugin paths.
                '';
                default = [];
              };

              configType = lib.mkOption {
                type = lib.types.enum ["hyprlang" "lua"];
                description = ''Type of config file to use for hyprland'';
                default = "lua";
              };

              extraSettings = lib.mkOption {
                type = with lib.types; let
                  valueType =
                    nullOr (oneOf [
                      bool
                      int
                      float
                      str
                      path
                      (attrsOf valueType)
                      (listOf valueType)
                    ])
                    // {
                      description = "Hyprland configuration value";
                    };
                in
                  valueType;
                description = ''
                  Hyprland extra configuration written in Nix added to the default
                  settings.
                '';
                default = {};
              };

              monitorConfig = lib.mkOption {
                type = with lib.types;
                  listOf (submodule {
                    options = {
                      output = lib.mkOption {
                        type = str;
                        description = "Monitor output name, `desc:…`, or empty string for a catch-all rule.";
                        default = "";
                      };
                      mode = lib.mkOption {
                        type = str;
                        description = ''
                          Resolution and refresh rate, e.g. `"1920x1080@144"`,
                          or one of `"preferred"`, `"highres"`, `"highrr"`, `"maxwidth"`.
                        '';
                        default = "preferred";
                      };
                      position = lib.mkOption {
                        type = str;
                        description = ''Position in the virtual layout, e.g. `"1920x0"`, or `"auto"`.'';
                        default = "auto";
                      };
                      scale = lib.mkOption {
                        type = either float (enum ["auto"]);
                        description = ''Scale factor, e.g. `1.5`, or `"auto"`.'';
                        default = "auto";
                      };
                      disabled = lib.mkOption {
                        type = bool;
                        description = "Remove the monitor from the layout.";
                        default = false;
                      };
                      transform = lib.mkOption {
                        type = nullOr int;
                        description = "Rotation/flip transform (0–7). `null` = unset.";
                        default = null;
                      };
                      mirror = lib.mkOption {
                        type = nullOr str;
                        description = "Output name to mirror. `null` = unset.";
                        default = null;
                      };
                      bitdepth = lib.mkOption {
                        type = nullOr (enum [8 10]);
                        description = "Bit depth (8 or 10). `null` = unset.";
                        default = null;
                      };
                      vrr = lib.mkOption {
                        type = nullOr int;
                        description = "VRR mode (0 = off, 1 = on, 2 = fullscreen only). `null` = unset.";
                        default = null;
                      };
                    };
                  });
                description = "List of monitor configurations.";
                default = [];
                example = lib.literalExpression ''
                  [
                    { output = "DP-1"; mode = "1920x1080@144"; position = "0x0"; scale = 1; }
                    { output = ""; mode = "preferred"; position = "auto"; scale = 1; }
                  ]
                '';
              };

              startupCommands = lib.mkOption {
                type = with lib.types; listOf str;
                description = ''
                  List of commands to execute on Hyprland startup (exec-once).
                  In Lua mode they are appended to the `hyprland.start` event
                  handler; in hyprlang mode they become `exec-once` lines.
                '';
                default = [];
                example = ["blueman-applet" "nm-applet --indicator"];
              };

              extraConfig = lib.mkOption {
                type = lib.types.lines;
                description = ''
                  Extra configuration lines to add to
                  `${config.xdg.configHome}/hypr/hyprland.conf`.
                '';
                default = "";
              };

              theme = {
                name = lib.mkOption {
                  type = lib.types.str;
                  description = "Name of the theme to install";
                  default = "default";
                };
              };

              systemd = {
                enableXdgAutostart = lib.mkDefaultEnabledOption ''
                  Whether to enable autostart of applications using {manpage};
                  `systemd-xdg-autostart-generator(8)`.
                  boolean
                '';
              };
            };
          };
        };
      };
    };
  };
}
