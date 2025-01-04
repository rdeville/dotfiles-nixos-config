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
    nixpkgs = {
      config = {
        allowUnfreePredicate = pkg:
          builtins.elem (lib.getName pkg) [
            "discord"
          ];
      };
    };

    home = {
      packages = with pkgs; [
        discord
      ];
    };
  };
}
