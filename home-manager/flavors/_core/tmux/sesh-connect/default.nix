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
    home = {
      packages = with pkgs; [
        yq-go # required by sesh-connect to parse sesh-connect.yaml
      ];

      file = {
        ".local/bin/sesh-connect" = {
          source = ./sesh-connect.sh;
          executable = true;
        };
      };
    };
  };
}
