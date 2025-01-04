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
    home = {
      packages = with pkgs; [
        age
        kubectl
        kubectx
        kubernetes-helm
        kubernetes-helmPlugins.helm-diff
        kubernetes-helmPlugins.helm-git
        kubernetes-helmPlugins.helm-secrets
        kubernetes-helmPlugins.helm-mapkubeapis
        sops
        stern
      ];
      sessionVariables = {
        # KUBECOLOR_CONFIG = "${config.xdg.configHome}/kube/kubecolor.yaml";
        KUBECONFIG = "${config.xdg.configHome}/kube/kubeconfig.yaml";
      };
    };

    programs = {
      k9s = {
        enable = true;
      };
      kubecolor = {
        enable = true;
        enableAlias = true;
        settings = {
          kubectl = lib.getExe pkgs.kubectl;
          preset = "dark";
          paging = "auto";
          objFreshThreshold = "4h";
        };
      };
    };
  };
}
