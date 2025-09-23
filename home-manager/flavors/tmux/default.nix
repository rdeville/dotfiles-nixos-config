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
        tmux = {
          source = pkgs.stdenv.mkDerivation {
            name = "tmux-data";
            src = ./.;
            installPhase = let
              hostCfg =
                if config.hm.isWork
                then ''
                  cp templates/pro.conf $out/hosts/${config.hm.hostName}.conf
                ''
                else if config.hm.isMain
                then ''
                  cp templates/perso.conf $out/hosts/${config.hm.hostName}.conf
                ''
                else if config.services.k3s.enable
                then ''
                  cp templates/mini_computer $out/hosts/${config.hm.hostName}.conf
                ''
                else ''
                  cp templates/server.conf $out/hosts/${config.hm.hostName}.conf
                '';
            in ''
              mkdir -p $out/hosts;
              ${hostCfg}
              cp -r \
                tmux.conf \
                templates \
                $out
            '';
          };
        };
      };
    };
  };
}
