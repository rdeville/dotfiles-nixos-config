{
  userCfg,
  config,
  pkgs,
  lib,
  ...
}: let
  cfg =
    if userCfg.flavors ? vscode
    then config.vscode // userCfg.flavors.vscode
    else {
      enable = false;
    };
in {
  options = {
    vscode = {
      enable = lib.mkEnableOption "Install VSCode Related Packages";
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
