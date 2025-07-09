{config, ...}: let
  mkLib = config.lib.topology;
in {
  nodes = {
    darth-vader = {
      deviceType = "device";
      deviceIcon = "devices.cloud-server";

      renderer = {
        preferredType = "card";
      };

      hardware = {
        info = "Intel Core (Haswell) @ 2.40 GHz, 2GB RAM";
        image = ../assets/images/devices/server-rack-1U.png;
      };

      interfaces = {
        eth0 = {
          icon = "interfaces.fiber-duplex";
          network = "internet";
          addresses = [
            "152.228.170.17"
          ];
          physicalConnections = [
            (mkLib.mkConnection "internet" "*")
          ];
        };
      };

      services = {
        nginx = {
          icon = "services.nginx";
          name = "Nginx";
          info = "romaindeville.fr";
          details = {
            "romaindeville.fr" = {text = "/var/www/__webapp_3";};
            "docs.romaindeville.fr" = {text = "/var/www/__webapp";};
          };
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
        roundcube = {
          name = "RoundCube";
          icon = ../assets/images/services/roundcube.png;
          details = {
            "mail.romaindeville.fr" = {text = "";};
          };
        };
        rspamd = {
          name = "Rspamd";
          icon = ../assets/images/services/rspamd.png;
        };
        ttrss = {
          name = "Tiny Tiny RSS";
          icon = ../assets/images/services/ttrss.png;
          details = {
            "rss.romaindeville.fr" = {text = "";};
          };
        };
        yunohost = {
          name = "Yunohost";
          icon = ../assets/images/services/yunohost.png;
        };
      };
    };
  };
}
