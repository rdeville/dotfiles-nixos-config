{
  config,
  lib,
  pkgs,
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
    xdg = {
      dataFile = {
        mr = {
          source = pkgs.stdenv.mkDerivation {
            name = "mr-data";
            src = ./.;
            installPhase = let
              hostCfg =
                if config.hm.isWork
                then ''
                  cp templates/pro/${config.hm.username}.git $out/hosts/${config.hm.hostName}/${config.hm.username}.git
                ''
                else if config.hm.isMain
                then ''
                  cp templates/perso/* $out/hosts/${config.hm.hostName}/
                ''
                else ''
                  cp templates/server/* $out/hosts/${config.hm.hostName}/
                '';
            in ''
              mkdir -p $out/hosts/${config.hm.hostName};
              ${hostCfg}
              cp -r \
                repos \
                templates \
                $out
            '';
          };
        };
      };
    };
  };
}
