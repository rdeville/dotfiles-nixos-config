{...}: {
  imports = [
    ../../../nixos/modules
  ];

  config = {
    k8s-microvms = {
      k8s-dev = {
        enable = false;
        env = "dev";
        clusterDomain = [
          "kube.dev.tekunix.internal"
        ];
        id = 201;
        vcpu = 1;
        mem = 4096;
        role = "server";
        clusterInit = true;
        defaultSopsFile = ./k8s-dev/secrets.enc.yaml;
        hostKeyDir = ./k8s-dev/_keys;
        network = {
          debug = true;
        };
      };
      k8s-stg = {
        enable = false;
        id = 201;
        vcpu = 1;
        mem = 4096;
        env = "stg";
        role = "agent";
        defaultSopsFile = ./k8s-stg/secrets.enc.yaml;
        hostKeyDir = ./k8s-stg/_keys;
        clusterAddress = "https://kube.stg.tekunix.internal";
        network = {
          debug = true;
        };
      };
      k8s-prd = {
        enable = false;
        id = 201;
        vcpu = 1;
        mem = 4096;
        env = "prd";
        role = "agent";
        defaultSopsFile = ./k8s-prd/secrets.enc.yaml;
        hostKeyDir = ./k8s-prd/_keys;
        clusterAddress = "https://kube.tekunix.internal";
      };
    };
  };
}
