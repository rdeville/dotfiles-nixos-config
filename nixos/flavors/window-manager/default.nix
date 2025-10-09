{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  name = builtins.baseNameOf ./.;
  cfg = config.os.flavors.${name};

  awesomePkg = let
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

        cmakeFlags =
          old.cmakeFlags
          ++ [
            "-DGENERATE_MANPAGES=OFF"
            "-DCMAKE_POLICY_VERSION_MINIMUM=3.5"
          ];
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
  options = {
    os = {
      flavors = {
        ${name} = {
          enable = lib.mkEnableOption "Install ${name} NixOS flavors.";

          awesome = {
            enable =
              lib.mkDependEnabledOption "Install awesome window manager"
              config.os.flavors.${name}.enable;
          };

          hyprland = {
            enable =
              lib.mkDependEnabledOption "Install hyprland window manager"
              config.os.flavors.${name}.enable;
          };

          plasma = {
            enable =
              lib.mkDependEnabledOption "Install hyprland window manager"
              config.os.flavors.${name}.enable;
          };
        };
      };
    };
  };

  config = lib.mkIf (! config.os.isDarwin && cfg.enable) {
    users = {
      users =
        builtins.mapAttrs (name: user: {
          extraGroups =
            if name != "root"
            then [
              "video"
              "audio"
              "camera"
            ]
            else [];
        })
        config.os.users.users;
    };

    environment = {
      plasma6 = lib.mkIf cfg.plasma.enable {
        excludePackages = with pkgs.kdePackages; [
          plasma-browser-integration
          konsole
          oxygen
        ];
      };
    };

    services = {
      xserver = {
        windowManager = {
          awesome = {
            enable = cfg.awesome.enable;
            luaModules = with pkgs.luaPackages; [
              luarocks # is the package manager for Lua modules
              pkgs.luajitPackages.lgi
            ];
            package = awesomePkg;
          };
        };
      };

      desktopManager = {
        plasma6 = {
          enable = cfg.plasma.enable;
        };
      };
    };

    programs = {
      hyprland = {
        enable = cfg.hyprland.enable;
      };
    };
  };
}
