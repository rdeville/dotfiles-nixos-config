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
    };

    programs = {
      zsh = let
        aliasAbbr = {
          h = "helm";
          # This command is used a LOT both below and in daily life
          k = "kubecolor";
          kn = "kubens";
          kx = "kubectx";
        };
      in {
        initExtra = ''
          source <(helm completion zsh)
          source <(kubectl completion zsh)

          # Associate kubectl autocompletion to kubecolor
          compdef _kubectl kubecolor
        '';

        localVariables = {
          KUBECOLOR_FORCE_COLORS = "truecolor";
          KUBECONFIG = "${config.xdg.configHome}/kube/kubeconfig.yaml";
        };

        shellAliases =
          aliasAbbr
          // {
            kubectl = "kubecolor";
          };

        zsh-abbr = {
          abbreviations =
            aliasAbbr
            // {
              # Helm
              h = "helm";
              hi = "helm install";
              hu = "helm upgrade";
              ht = "helm template";

              # Helm Diff
              hdu = "helm diff upgrade";

              # Kubernetes
              # Apply a YML file
              kaf = "kubectl apply -f";
              kak = "kubectl apply -k";
              # into an interactive terminal on a container
              keti = "kubectl exec -ti";
              # Shortcuts
              kg = "kubectl get";
              kd = "kubectl describe";
              # Pod management.
              kgp = "kubectl get pods";
              kgpw = "kgp --watch";
              kgpwide = "kgp -o wide";
              kdp = "kubectl describe pods";
              # Service management.
              kgs = "kubectl get svc";
              kgsw = "kgs --watch";
              kgswide = "kgs -o wide";
              kds = "kubectl describe svc";
              # Ingress management
              kgi = "kubectl get ingress";
              kdi = "kubectl describe ingress";
              # Namespace management
              kgns = "kubectl get namespaces";
              kdns = "kubectl describe namespace";
              # ConfigMap management
              kgcm = "kubectl get configmaps";
              kdcm = "kubectl describe configmap";
              # Secret management
              kgsec = "kubectl get secret";
              kdsec = "kubectl describe secret";
              # Deployment management.
              kgd = "kubectl get deployment";
              kgdw = "kgd --watch";
              kgdwide = "kgd -o wide";
              kdd = "kubectl describe deployment";
              krsd = "kubectl rollout status deployment";
              krrd = "kubectl rollout restart deployment";
              # Rollout management.
              kgrs = "kubectl get rs";
              # Port forwarding
              kpf = "kubectl port-forward";
              # Tools for accessing all information
              kga = "kubectl get all";
              kgaa = "kubectl get all --all-namespaces";
              # Logs
              kl = "kubectl logs";
              klf = "kubectl logs -f";
              # Node Management
              kgno = "kubectl get nodes";
              kdno = "kubectl describe node";
            };
        };
      };

      k9s = {
        enable = true;
      };

      kubecolor = {
        enable = true;
        settings = {
          kubectl = lib.getExe pkgs.kubectl;
          preset = "dark";
          paging = "never";
          objFreshThreshold = "4h";
        };
      };
    };
  };
}
