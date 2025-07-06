{lib, ...}: let
  rules =
    builtins.foldl'
    (
      acc: elem:
        [
          # creates a symlink of each MicroVM's journal under the host's /var/log/journal
          "d /var/lib/microvms/vm-${elem}/var 0755 microvm kvm -"
          "d /var/lib/microvms/vm-${elem}/volumes 0755 microvm kvm -"
          "d /var/lib/microvms/vm-${elem}/var/log 0755 microvm systemd-journal -"
          "L+ /var/log/journal/vm-${elem} - - - - /var/lib/microvms/vm-${elem}/var/log/journal"
        ]
        ++ acc
    ) []
    (lib.listDirs ./.);
in {
  imports = [
    ./k8s-stg
  ];

  systemd = {
    tmpfiles = {
      inherit rules;
    };
  };

  networking = {
    nat = {
      enable = lib.mkForce true;
      internalIPs = ["172.16.144.0/24"];
    };
  };

  services = {
    nginx = {
      enable = true;

      virtualHosts = {
        "*.tekunix.cloud" = {
          listen = [
            {
              addr = "89.234.140.170";
              port = 80;
            }
            {
              addr = "89.234.140.170";
              port = 443;
            }
          ];

          locations = {
            "/robots.txt" = {
              extraConfig = ''
                rewrite ^/(.*)  $1;
                return 200 "User-agent: *\nDisallow: /";
              '';
            };
          };
        };
      };
    };
  };
}
