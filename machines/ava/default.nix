{
  inputs,
  config,
  ...
}: {
  imports = [
    # Templated config
    ../_templates/server.nix
    ../_templates/k3s.nix
    # Partition map
    inputs.disko.nixosModules.disko
    ./disko.nix
    ./topology.nix
    ./network.nix
  ];

  sops = {
    secrets = {
      "k8s-prd-token" = {
        sopsFile = ../../common/secrets/k8s-prd.enc.yaml;
      };
    };
  };

  os = {
    hostName = builtins.baseNameOf ./.;

    flavors = {
      k3s = {
        role = "agent";
        serverAddr = "https://kube.prd.tekunix.internal:6443";
        tokenFile = config.sops.secrets."k8s-prd-token".path;
        extraFlags = [
          "--node-ip 172.30.128.23"
          "--node-external-ip 172.30.128.23"
        ];
      };
    };
  };
}
