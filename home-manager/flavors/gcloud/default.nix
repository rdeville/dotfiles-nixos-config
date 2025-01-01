{
  config,
  pkgs,
  lib,
  ...
}: let
  name = builtins.baseNameOf ./.;
  cfg = config.hm.flavors.${name};
in {
  options = {
    hm = {
      flavors = {
        ${name} = {
          enable = lib.mkEnableOption "Install discord Related Packages";
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        google-cloud-sdk
        google-cloud-sql-proxy
      ];
    };
  };
}
