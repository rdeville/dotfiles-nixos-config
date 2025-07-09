{...}: let
  internal-net = [
    # Localhost
    "192.168.1.0/24"
    # Public Ethernet
    "172.16.1.0/24"
    # Public Wlan
    "172.16.2.0/24"
    # K8S PRD vlan
    "172.16.128.0/20"
    # K8S stg vlan
    "172.16.144.0/20"
    # Public Wireguard
    "172.17.1.0/24"
  ];
  private-net = [
    # Private Wireguard
    "172.18.0.0/16"
  ];
  kubernetes-net = [
    # k8s prd Wireguard
    "172.30.128.0/24"
    # k8s stg Wireguard
    "172.30.144.0/24"
    # k8s dev Wireguard
    "172.30.160.0/24"
  ];
in {
  systemd = {
    services = {
      bind = {
        after = [
          "systemd-networkd.service"
        ];
      };
    };
  };

  services = {
    bind = {
      enable = true;
      ipv4Only = true;
      forwarders = [
        # FDN DNS
        "80.67.169.12"
        "80.67.169.40"
      ];

      extraConfig = ''
        acl "private_client" {
          ${builtins.concatStringsSep ";" private-net};
        };

        acl "internal_client" {
          ${builtins.concatStringsSep ";" internal-net};
        };

        acl "kubernetes_client" {
          ${builtins.concatStringsSep ";" kubernetes-net};
        };


        view "private_client" {
          match-clients {
            "private_client";
          };
          allow-query-cache {
            "private_client";
          };
          recursion yes;
          zone "tekunix.private" {
            type master;
            file "${./tekunix.private}";
          };
          zone "tekunix.cloud" {
            type master;
            file "${./tekunix.cloud.internal}";
          };
        };

        view "kubernetes_client" {
          match-clients {
            "kubernetes_client";
          };
          allow-query-cache {
            "kubernetes_client";
          };
          recursion yes;
          zone "tekunix.internal" {
            type master;
            file "${./tekunix.internal}";
          };
        };

        view "internal_client" {
          match-clients {
            "localhost";
            "internal_client";
          };
          allow-query-cache {
            "internal_client";
          };
          recursion yes;
          zone "tekunix.cloud" {
            type master;
            file "${./tekunix.cloud.internal}";
          };
        };

        view "everyone_else" {
          match-clients {
            any;
          };
          allow-query-cache {
            any;
          };
          recursion yes;
          zone "tekunix.cloud" {
            type master;
            file "${./tekunix.cloud}";
          };
        };
      '';
    };
  };
}
