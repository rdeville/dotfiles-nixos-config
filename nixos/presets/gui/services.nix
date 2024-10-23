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
          if (presetCfg ? windowManager && presetCfg.windowManager ? awesome)
          then "none+awesome"
          else if (presetCfg ? windowManager && presetCfg.windowManager ? hyprland)
          then "hyprland"
          else null;
        gdm = lib.mkIf (presetCfg ? displayManager && presetCfg.displayManager ? gdm) {
          enable = true;
          wayland = lib.mkIf (presetCfg ? windowManager && presetCfg.windowManager ? hyprland) true;
        };
      };

      windowManager = {
        awesome = {
          enable = lib.mkIf (presetCfg ? windowManager && presetCfg.windowManager ? awesome) true;
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
    hyprland = lib.mkIf (presetCfg ? windowManager && presetCfg.windowManager ? hyprland) {
      enable = true;
    };
  };

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs;
    [
      firefox
      kitty
      pcmanfm
    ]
    ++ [(lib.mkIf (presetCfg ? windowManager && presetCfg.windowManager ? awesome) rofi)]
    ++ [(lib.mkIf (presetCfg ? windowManager && presetCfg.windowManager ? hyprland) wofi)];
}
