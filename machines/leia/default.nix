{inputs, ...}: let
  id = 21;
  prefix = "172.16.144";
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
    role = "agent";
    env = "stg";
    hostKeyDir = ./_keys;
    clusterAddress = "https://kube.stg.tekunix.internal";
    network = {
      debug = true;
    };
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
            interface = "enp3s0";
            matchConfig = {
              name = "enp3s*";
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

          k8s-stg = {
            interface = "k8s-stg";
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
              id = 144;
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
                  iface = "k8s-stg";
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
        info = "Intel Celeron J1900 @ 1.99GHz, 8Go DDR3";
        image = ../../assets/images/devices/brix.png;
      };
    };
  };
}
