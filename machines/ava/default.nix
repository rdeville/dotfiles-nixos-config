{inputs, ...}: let
  id = 33;
  prefix = "172.16.128";
in {
  imports = [
    # Templated config
    ../_templates/server.nix
    # Partition map
    inputs.disko.nixosModules.disko
    ./disko.nix
  ];

  k8s-server = {
    inherit id;
    enable = true;
    role = "server";
    env = "prd";
    hostKeyDir = ./_keys;
    clusterAddress = "https://kube.tekunix.internal";
    wireguard = {
      endpoint = "${prefix}.1";
    };
  };

  os = {
    hostName = builtins.baseNameOf ./.;
    flavors = {
      network = {
        enable = true;
        networks = {
          eth-k8s = {
            interface = "TODO: CHANGEME";
            matchConfig = {
              name = "TODO: CHANGEME";
            };
            DHCP = "no";
            activationPolicy = "up";
            requiredForOnline = "no";
            topology = {
              connections = [
                {
                  to = "k8s-switch";
                  iface = "eth";
                  reversed = true;
                }
              ];
            };
          };

          k8s-prd = {
            interface = "k8s-prd";
            DHCP = "yes";
            activationPolicy = "up";
            requiredForOnline = "yes";
            nftables = {
              allowInputConnected = true;
              forward = {
                inputInterfaces = [
                  # Container go to internet via k8s-stg
                  "lxc*"
                ];
                outputInterfaces = [
                  # Response from internet through k8s-stg to cilium
                  "cilium_host"
                ];
              };
            };
            vlan = {
              enable = true;
              id = 128;
              vlanInterfaces = [
                "eth-k8s"
              ];
            };

            topology = {
              addresses = [
                "${prefix}.${toString id}"
              ];
              connections = [
                {
                  to = "kenobi";
                  iface = "k8s-prd";
                  reversed = true;
                }
              ];
            };
          };
        };
      };
    };
  };

  topology = {
    self = {
      hardware = {
        info = "TODO";
        image = ../../assets/images/devices/acemagic-cyberpunk.png;
      };
    };
  };
}
