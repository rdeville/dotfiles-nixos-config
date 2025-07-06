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
      enable = true;
      internalIPs = [
        "172.20.0.0/24"
      ];
    };
  };

  services = {
    nginx = {
      enable = true;

      virtualHosts = {
        "*.rey.tekunix.cloud" = {
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
