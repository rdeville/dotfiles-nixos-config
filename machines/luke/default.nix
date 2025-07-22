{
  inputs,
  config,
  lib,
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
  ];

  networking = {
    firewall = {
      enable = lib.mkForce false;
      allowedUDPPorts = [];
      #   # Cilium Port
      #   # See: https://docs.cilium.io/en/stable/operations/system_requirements/
      #   # Wireguard
      #   51871
      # ];
      allowedTCPPorts = [];
      #   # Kube API
      #   6443
      #   # Cilium Port
      #   # See: https://docs.cilium.io/en/stable/operations/system_requirements/
      #   # Cilium health
      #   4240
      #   # Cilium metrics
      #   10250
      #   # Hubble metrics
      #   9965
      #   # Hubble peer
      #   4244
      # ];
      # # See: https://github.com/cilium/cilium/issues/27900#issuecomment-2572253315
      # trustedInterfaces = [
      #   "cilium_net*"
      #   "cilium_host*"
      #   "cilium_vxlan"
      #   "lxc*"
      # ];
    };
  };

  sops = {
    secrets = {
      "k3s-stg-token" = {
        sopsFile = ../../common/secrets/k3s-stg.enc.yaml;
      };
    };
  };

  os = {
    hostName = builtins.baseNameOf ./.;

    flavors = {
      k3s = {
        role = "server";
        disableAgent = false;
        clusterInit = true;
        tokenFile = config.sops.secrets."k3s-stg-token".path;
      };
    };
  };
}
