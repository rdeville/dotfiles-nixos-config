{...}: {
  config = {
    k8s-microvms = {
      k8s-dev = {
        enable = false;
        id = 203;
        vcpu = 2;
        mem = 4096;
        env = "dev";
        clusterAddress = "https://kube.dev.tekunix.internal";
        role = "agent";
        defaultSopsFile = ./k8s-dev/secrets.enc.yaml;
        hostKeyDir = ./k8s-dev/_keys;
        wireguard = {
          endpoint = "89.234.140.170";
        };
      };
    };
  };
}
