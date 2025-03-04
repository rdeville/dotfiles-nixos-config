{
  config,
  lib,
  pkgs,
  hm,
  ...
}: let
  name = builtins.baseNameOf ./.;
  cfg = config.hm.flavors.${name};

  linuxPkgs = with pkgs; [
    bluetuith
  ];

  darwinPkgs = [];
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
      packages =
        if config.hm.isDarwin
        then darwinPkgs
        else linuxPkgs;
    };

    xdg = {
      configFile = {
        "bluetuith/bluetuith.conf" = {
          enable = with pkgs; builtins.elem bluetuith config.home.packages;
          text = ''
            {
              keybindings: {
                Menu : Shift+m
                Quit: q
              }
            }
            # vim: ft=hjson
          '';
        };
      };
    };
  };
}
