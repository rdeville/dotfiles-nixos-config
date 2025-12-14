{
  config,
  lib,
  pkgs,
  ...
}: let
  name = builtins.baseNameOf ./.;
  cfg = config.hm.flavors.${name};

  linuxPkgs = with pkgs; [
    arandr
    kdePackages.kolourpaint
    vlc
  ];
  darwinPkgs = [];
in {
  imports = [
    ./aerospace
    ./awesome
    ./firefox
    ./jankyborders
    ./kitty
    ./rofi
    ./sketchybar
    ./thunderbird
    ./wayland
    ./alacritty.nix
    ./chromium.nix
    ./dunst.nix
    ./gammastep.nix
    ./gtk.nix
    ./keynav.nix
    ./picom.nix
    ./redshift.nix
  ];

  options = {
    hm = {
      flavors = {
        ${name} = {
          enable = lib.mkEnableOption "Install ${name} Home-Manager flavor.";
          font = {
            name = lib.mkOption {
              type = lib.types.str;
              description = "Name of the default font to use in GUI.";
              default = "FiraCode Nerd Font";
            };
            size = lib.mkOption {
              type = lib.types.int;
              description = "Default font size applied to all GUI.";
              default = 14;
            };
            pkgs = lib.mkOption {
              type = lib.types.package;
              description = "Font pkgs to install.";
              default = pkgs.nerd-fonts.fira-code;
            };
          };
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs;
        [
          keepassxc
        ]
        ++ (
          if config.hm.isDarwin
          then darwinPkgs
          else linuxPkgs
        );
    };
  };
}
