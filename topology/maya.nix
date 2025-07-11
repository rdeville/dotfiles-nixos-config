{config, ...}: {
  nodes = {
    maya = {
      deviceType = "device";
      deviceIcon = "devices.nixos";

      renderer = {
        preferredType = "card";
      };

      # https://www.amazon.fr/Cyberpunk-8845HS-jusqu%C3%A0-Ordinateur-Double-Ventilateur/dp/B0D1TNTF9Y
      hardware = {
        info = "AMD Ryzen 7 8845HS @ 5,1 GHz, 32Go DDR5";
        image = ../assets/images/devices/acemagic-cyberpunk.png;
      };

      interfaces = {
        enp0s1 = {
          addresses = [
            "172.16.128.11"
          ];
          type = "ethernet";
          network = "k8s-prd";
          physicalConnections = [
            (config.lib.topology.mkConnectionRev "k8s-switch" "eth4")
          ];
        };

        wg-kenobi-pri = {
          addresses = [
            "172.18.1.130"
          ];
          type = "wireguard";
          virtual = true;
          physicalConnections = [
            (config.lib.topology.mkConnectionRev "kenobi" "wg-private")
          ];
        };
      };

      services = {
        openssh = {
          name = "OpenSSH";
          icon = "services.openssh";
        };
      };
    };
  };
}
