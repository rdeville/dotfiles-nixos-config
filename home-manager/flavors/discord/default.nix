{
  config,
  pkgs,
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
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        discord
      ];
    };

    xdg = {
      configFile = {
        "discord/settings.json" = {
          text = builtins.toJSON {
            SKIP_HOST_UPDATE = true;
          };
        };
      };
    };
  };
}
