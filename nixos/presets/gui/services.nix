{
  inputs,
  hostCfg,
  presetCfg,
  pkgs,
  lib,
  ...
}: let
  awesome = let
    extraGIPackages = with pkgs; [networkmanager upower];
  in
    ((pkgs.awesome.override {gtk3Support = true;}).overrideAttrs
      (old: {
        version = "git-main";
        src = inputs.awesome;

        patches = [];

        postPatch = ''
          patchShebangs tests/examples/_postprocess.lua
          patchShebangs tests/examples/_postprocess_cleanup.lua
        '';

        cmakeFlags = old.cmakeFlags ++ ["-DGENERATE_MANPAGES=OFF"];
        GI_TYPELIB_PATH = let
          mkTypeLibPath = pkg: "${pkg}/lib/girepository-1.0";
          extraGITypeLibPaths = lib.forEach extraGIPackages mkTypeLibPath;
        in
          lib.concatStringsSep ":" (extraGITypeLibPaths ++ [(mkTypeLibPath pkgs.pango.out)]);
      }))
    .override {
      lua = pkgs.luajit;
      gtk3Support = true;
    };

  awesomeEnable =
    if
      presetCfg
      ? windowManager
      && presetCfg.windowManager ? awesome
      && presetCfg.windowManager.awesome ? enable
    then presetCfg.windowManager.awesome.enable
    else false;

  hyprlandEnable =
    if
      presetCfg
      ? windowManager
      && presetCfg.windowManager ? hyprland
      && presetCfg.windowManager.hyprland ? enable
    then presetCfg.windowManager.hyprland.enable
    else false;

  gdmEnable =
    if
      presetCfg
      ? windowManager
      && presetCfg.displayManager ? gdm
      && presetCfg.displayManager.gdm ? enable
    then presetCfg.displayManager.gdm.enable
    else false;
in {
  services = {
    xserver = {
      # Enable the X11 windowing system.
      enable = true;

      # Configure keymap in X11
      xkb = {
        layout = hostCfg.keyMap;
        options = "caps:escape";
      };

      displayManager = {
        defaultSession =
          if awesomeEnable
          then "none+awesome"
          else if hyprlandEnable
          then "hyprland"
          else null;
        gdm = {
          enable = gdmEnable;
          wayland = hyprlandEnable;
        };
      };

      windowManager = {
        awesome = {
          enable = awesomeEnable;
          luaModules = with pkgs.luaPackages; [
            luarocks # is the package manager for Lua modules
            pkgs.luajitPackages.lgi
          ];
          package = awesome;
        };
      };
    };
  };

  programs = {
    hyprland = {
      enable = hyprlandEnable;
    };
  };

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs;
    [
      firefox
      kitty
      pcmanfm
    ]
    ++ [(lib.mkIf awesomeEnable rofi)]
    ++ [(lib.mkIf hyprlandEnable wofi)];
}
