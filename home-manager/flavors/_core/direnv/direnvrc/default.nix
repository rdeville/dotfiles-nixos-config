{
  config,
  lib,
  pkgs,
  ...
}: let
  name = builtins.baseNameOf ../../.;
  subname = builtins.baseNameOf ../.;
  subsubname = builtins.baseNameOf ./.;
  cfg = config.hm.flavors.${name}.${subname}.${subsubname};
in {
  options = {
    hm = {
      flavors = {
        ${name} = {
          ${subname} = {
            ${subsubname} = {
              enable =
                lib.mkDependEnabledOption ''
                  Install ${name}.${subname} Home-Manager flavor.
                ''
                (
                  config.hm.flavors.${name}.enable
                  && config.hm.flavors.${name}.${subname}.enable
                );
            };
          };
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    xdg = {
      configFile = {
        direnv = {
          source = pkgs.stdenv.mkDerivation {
            name = "direnvrc";
            src = ./.;
            phases = ["unpackPhase" "installPhase"];
            installPhase = ''
              mkdir -p $out;
              cp -r \
                direnv.toml \
                direnvrc \
                lib \
                templates \
                tools \
                $out
            '';
          };
        };
      };
    };
  };
}
