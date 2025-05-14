{
  net = {
    "enp1s0" = {
      useDHCP = true;
    };

    "enp2s0" = {
      prefix = "172.16.1"; # Up to 172.16.2 excluded
      length = 24;
    };

    "enp3s0" = {
      k8s-prd = {
        id = 128;
        prefix = "172.16.128"; # Up to 172.16.144 excluded
        length = 20;
      };
      k8s-stg = {
        id = 144;
        prefix = "172.16.144"; # Up to 172.16.160 excluded
        length = 20;
      };
    };

    "enp4s0" = {
      iot = {
        id = 208;
        prefix = "172.16.208"; # Up to 172.16.224 excluded
        length = 20;
      };
    };
  };

  wlan = {
    "wlp5s0f0" = {
      wl-public = {
        prefix = "172.16.2"; # Up to 172.16.3 excluded
        length = 20;
      };
    };
  };

  vpn = {
    wg-public = {};
    wg-private = {};
    wg-illyse = {};
  };
}
