{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  name = builtins.baseNameOf ../.;
  subname = builtins.baseNameOf ./.;
  cfg = config.hm.flavors.${name}.${subname};
  awesome = let
    extraGIPackages = with pkgs; [networkmanager upower];
  in
    ((pkgs.awesome.override {gtk3Support = true;}).overrideAttrs (old: {
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
        extraGITypeLibPaths = pkgs.lib.forEach extraGIPackages mkTypeLibPath;
      in
        pkgs.lib.concatStringsSep ":" (extraGITypeLibPaths ++ [(mkTypeLibPath pkgs.pango.out)]);
    }))
    .override {
      lua = pkgs.luajit;
      gtk3Support = true;
    };
in {
  options = {
    hm = {
      flavors = {
        ${name} = {
          ${subname} = {
            enable = lib.mkEnableOption "Install ${name}.${subname} Home-Manager flavor.";
          };
        };
      };
    };
  };

  config = lib.mkIf (cfg.enable && ! config.hm.isDarwin) {
    home = {
      file = {
        ".xinitrc" = {
          source = ./xinitrc;
        };
      };
    };

    xsession = {
      windowManager = {
        awesome = {
          enable = true;
          luaModules = with pkgs.luaPackages; [
            luarocks
            luajitPackages.lgi
          ];
          package = awesome;
        };
      };
    };

    xdg = {
      configFile = {
        awesome = {
          source = pkgs.stdenv.mkDerivation {
            name = "awesomerc";
            srcs = [
              (builtins.path {
                name = "bling";
                path = inputs.bling;
              })
              (builtins.path {
                name = "awesome";
                path = ./.;
              })
            ];
            sourceRoot = ".";
            phases = ["unpackPhase" "installPhase"];
            # Keep `awesome/` below, since content if the current flavor folder
            # is put in `awesome/` folder in the derivation as defined in the
            # source `srcs` above.
            installPhase = ''
              mkdir -p $out;
              cp -r \
                awesome/config \
                awesome/theme \
                awesome/utils \
                awesome/widgets \
                awesome/rc.lua \
                bling \
                $out
            '';
          };
        };
      };
    };
  };
}
