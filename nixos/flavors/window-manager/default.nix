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
  imports = builtins.map (item: ./${item}) (lib.importDir ./.);

  options = {
    os = {
      users = {
        users = lib.mkOption {
          type = lib.types.attrsOf (
            lib.types.submodule ({name, ...}: {
              options = {
                enableGui = lib.mkOption {
                  type = lib.types.bool;
                  description = ''
                    Set to true to add user to graphics related *NIX groups
                  '';
                  default =
                    if name != "root"
                    then true
                    else false;
                };
              };
            })
          );
        };
      };

      flavors = {
        ${name} = {
          enable = lib.mkEnableOption "Install ${name} NixOS flavors.";

          awesome = {
            enable = lib.mkEnableOption "Install awesome window manager";
          };

          hyprland = {
            enable = lib.mkEnableOption "Install hyprland window manager";
          };
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    users = {
      users =
        builtins.mapAttrs (name: user: {
          extraGroups = [
            "video"
            "audio"
            "camera"
          ];
        })
        config.os.users.users;
    };

    environment = {
      plasma6 = {
        excludePackages = with pkgs.kdePackages; [
          plasma-browser-integration
          konsole
          oxygen
        ];
      };
    };

    services = {
      xserver = {
        displayManager = {
          gdm = {
            wayland = cfg.hyprland.enable;
          };
        };

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
          enable = true;
        };
      };

      displayManager = {
        defaultSession =
          if cfg.awesome.enable
          then "none+awesome"
          else if cfg.hyprland.enable
          then "hyprland"
          else null;
      };
    };

    programs = {
      hyprland = {
        enable = cfg.hyprland.enable;
      };
    };
  };
}
