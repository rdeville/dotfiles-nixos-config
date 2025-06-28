{config, ...}: let
  mkLib = config.lib.topology;
in {
  nodes = {
    chewbacca = {
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
            (mkLib.mkConnection "k8s-switch" "eth4")
          ];
        };

        wg-kenobi-pri = {
          addresses = [
            "172.18.1.130"
          ];
          type = "wireguard";
          virtual = true;
          physicalConnections = [
            (mkLib.mkConnection "kenobi" "wg-private")
          ];
        };
      };

      services = {
        k8s = {
          name = "Kubernetes Control Plane & Worker";
          icon = ../assets/images/services/kubernetes.png;
        };

        openssh = {
          name = "OpenSSH";
          icon = "services.openssh";
        };
      };
    };
  };
}
