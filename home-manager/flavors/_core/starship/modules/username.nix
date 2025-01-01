{
  config,
  lib,
  ...
}: let
  name = "username";
  cfg = mkLib.mkGetSarshipModuleConfig name;
  mkLib = import ../lib.nix {inherit config;};

  sep = mkLib.sep.${cfg.position};
  bg = mkLib.colors.green_300;
  fg = mkLib.colors.grey_900;
  fg_root = mkLib.colors.red_500;
  # emphasis
  em = "bold";
in {
  options = mkLib.mkSetStarshipModuleOptions name {
    disabled = lib.mkEnableOption "Disable starship ${name} module.";
    position = lib.mkOption {
      type = lib.types.str;
      description = "Position of the module (right or left)";
      default = "right";
    };
  };

  config = {
    programs = {
      starship = {
        settings = {
          ${name} = {
            inherit
              (cfg)
              disabled
              ;

            # Always shows the username module.
            show_always = true;
            # Translate system usernames to something else
            aliases = {
              "${config.hm.username}" = "me";
              "root" = "GOD";
            };

            # The style used when the user is root/admin.
            style_root = "${em} bg:${bg} fg:${fg_root}";
            # The style used for non-root users.
            style_user = "bg:${bg} fg:${fg}";

            # The format for the module.
            format = lib.concatStrings [
              (sep bg)
              "[  $user ]($style)"
            ];
          };
        };
      };
    };
  };
}
