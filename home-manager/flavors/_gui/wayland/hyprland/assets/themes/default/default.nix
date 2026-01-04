{
  config,
  lib,
  ...
}: let
  name = builtins.baseNameOf ../../../../../.;
  subname = builtins.baseNameOf ../../../../.;
  subsubname = builtins.baseNameOf ../../../.;
  themeName = builtins.baseNameOf ./.;
  cfg = config.hm.flavors.${name}.${subname}.${subsubname};
  clr = config.colors.material;
in
  lib.mkIf (cfg.theme.name == themeName) {
    wayland = {
      windowManager = {
        hyprland = {
          settings = {
            general = {
              border_size = 2;
              gaps_in = 5;
              gaps_out = 10;
              "col.active_border" = "rgba(${clr.str.cyan_A400}ee) rgba(${clr.str.green_A400}ee) 45deg";
              "col.inactive_border" = "rgba(${clr.str.grey_900}aa)";
              # gaps_workspaces = "TODO"; #gaps between workspaces. Stacks with gaps_out.	int	0
              # col.inactive_border = "TODO"; #border color for inactive windows	gradient	0xff444444
              # col.active_border = "TODO"; #border color for the active window	gradient	0xffffffff
              # col.nogroup_border = "TODO";
              # #inactive border color for window that cannot be added to a group
              # (see denywindowfromgroup dispatcher)	gradient	0xffffaaff
              # col.nogroup_border_active = "TODO";
              #active border color for window that cannot be added to a group	gradient	0xffff00ff
              layout = "master";
              # no_focus_fallback = "TODO"; #if true, will not fall back to the next available window when moving focus in a direction where no window was found	bool	false
              # resize_on_border = "TODO"; #enables resizing windows by clicking and dragging on borders and gaps	bool	false
              # extend_border_grab_area = "TODO"; #extends the area around the border where you can click and drag on, only used when general:resize_on_border is on.	int	15
              # hover_icon_on_border = "TODO"; #show a cursor icon when hovering over borders, only used when general:resize_on_border is on.	bool	true
              # allow_tearing = "TODO"; #master switch for allowing tearing to occur. See the Tearing page.	bool	false
              # resize_corner = "TODO"; #force floating windows to use a specific corner when being resized (1-4 going clockwise from top left, 0 to disable)	int	0
            };
          };
        };
      };
    };
  }
