{...}: let
  internalNetworks = [
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
  privateNetworks = [
    # Private Wireguard
    "172.18.0.0/16"
  ];
in {
  services = {
    bind = {
      enable = true;
      ipv4Only = true;
      forwarders = [
        "80.67.169.12"
        "80.67.169.40"
      ];

      extraConfig = ''
        acl "private_client" {
          ${builtins.concatStringsSep ";" privateNetworks};
        };

        acl "internal_client" {
          ${builtins.concatStringsSep ";" internalNetworks};
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
