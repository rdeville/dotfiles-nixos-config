{
  config,
  inputs,
  pkgs,
  ...
}: let
  ai-robots-txt = "haproxy/ai-robots.txt";
  nginx = {
    listen = [
      {
        addr = "127.0.0.1";
        port = 8000;
      }
    ];

    locations = {
      "/robots.txt" = {
        extraConfig = ''
          rewrite ^/(.*)  $1;
          return 200 "User-agent: *\nDisallow: /\n";
        '';
      };
      "/" = {};
    };
  };
in {
  systemd = {
    tmpfiles = {
      rules = [
        # Create folder needed for VM volumes
        "d /var/run/haproxy 0755 root root -"
        "d /var/lib/haproxy 0755 root root -"
      ];
    };
  };

  environment = {
    etc = {
      ${ai-robots-txt} = {
        source = inputs.ai-robot-txt + "/haproxy-block-ai-bots.txt";
      };
    };
  };

  services = {
    nginx = {
      enable = true;
      virtualHosts = {
        "*.tekunix.cloud" = {
          inherit (nginx) listen locations;
          extraConfig = builtins.readFile (inputs.ai-robot-txt + "/nginx-block-ai-bots.conf");
        };
        "*.romaindeville.xyz" = {
          inherit (nginx) listen locations;
          extraConfig = builtins.readFile (inputs.ai-robot-txt + "/nginx-block-ai-bots.conf");
        };
      };
    };

    haproxy = {
      enable = true;
      config = builtins.readFile (
        pkgs.replaceVars ./haproxy.cfg {
          ai_robots_txt = config.environment.etc.${ai-robots-txt}.source;
          nginx = "${(builtins.elemAt nginx.listen 0).addr}:${toString (builtins.elemAt nginx.listen 0).port}";
        }
      );
    };
  };

  topology = {
    self = {
      services = {
        haproxy = {
          name = "HAProxy";
          info = "Load Balancer";
          icon = ../../../assets/images/services/haproxy.png;
          details = {
            "*.romaindeville.xyz" = {
              text = "";
            };
            "*.tekunix.cloud" = {
              text = "";
            };
          };
        };
      };
    };
  };
}
