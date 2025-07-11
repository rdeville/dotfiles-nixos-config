{config, ...}: {
  nodes = {
    darth-plagueis = {
      deviceType = "device";
      deviceIcon = "devices.cloud-server";

      renderer = {
        preferredType = "card";
      };

      hardware = {
        info = "Intel Atom N2800 @ 1.86 GHz, 4GB RAM";
        image = ../assets/images/devices/server-rack-1U.png;
      };

      interfaces = {
        eth0 = {
          icon = "interfaces.fiber-duplex";
          addresses = [
            "5.39.81.48"
          ];
          network = "internet";
          physicalConnections = [
            (config.lib.topology.mkConnection "internet" "*")
          ];
        };
      };

      services = {
        nextcloud = {
          name = "Nextcloud";
        };
        nginx = {
          name = "Nginx";
          info = "romaindeville.ovh";
        };
        dnsmasq = {
          name = "Dnsmasq";
          icon = "services.dnsmasq";
        };
        openssh = {
          name = "OpenSSH";
          icon = "services.openssh";
        };
        fail2ban = {
          name = "Fail2Ban";
          icon = "services.fail2ban";
        };
        dovecot = {
          name = "Dovecot";
          icon = ../assets/images/services/dovecot.png;
        };
        redis = {
          name = "Redis";
          icon = ../assets/images/services/redis.png;
        };
        mail = {
          name = "Mail Server";
          icon = ../assets/images/services/mail-server.png;
        };
        rspamd = {
          name = "Rspamd";
          icon = ../assets/images/services/rspamd.png;
        };
        yunohost = {
          name = "Yunohost";
          icon = ../assets/images/services/yunohost.png;
        };
      };
    };
  };
}
