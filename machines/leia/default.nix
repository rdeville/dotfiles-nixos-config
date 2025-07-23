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
      "k8s-stg-token" = {
        sopsFile = ../../common/secrets/k8s-stg.enc.yaml;
      };
    };
  };

  os = {
    hostName = builtins.baseNameOf ./.;

    flavors = {
      k3s = {
        role = "server";
        disableAgent = false;
        serverAddr = "https://kube.stg.tekunix.cloud:6443";
        tokenFile = config.sops.secrets."k8s-stg-token".path;
      };
    };
  };
}
