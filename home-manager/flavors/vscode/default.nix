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
          enable = lib.mkEnableOption "Install ${name} Home-Manager flavor.";
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs = {
      vscode = {
        enable = true;
        extensions = with pkgs.vscode-extensions; [
          hashicorp.hcl
          hashicorp.terraform
          ms-vsliveshare.vsliveshare
        ];
      };
    };
  };
}
