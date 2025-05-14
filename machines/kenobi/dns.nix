{pkgs, ...}: {
  services = {
    bind = {
      enable = true;
      # Networks allow to use this server as cache
      cacheNetworks = [
        "192.168.0.0/24"
      ];
      zones = {
        "tekunix.com" = {
          master = true;
          allowQuery = [
            # Public Ethernet
            "172.16.1.0/24"
            # Public Wlan
            "172.16.2.0/24"
            # K8S PRD vlan
            "172.16.128.0/20"
            # K8S stg vlan
            "172.16.144.0/20"
          ];
          file = pkgs.writeText "tekunix.cloud" (toString ./_assets/dns/tekunix.cloud);
        };
      };
    };
  };
}
