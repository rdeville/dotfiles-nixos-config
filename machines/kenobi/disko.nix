{
  disko = {
    devices = {
      disk = {
        primary = {
          type = "disk";
          device = "/dev/nvme0n1";
          content = {
            type = "gpt";
            partitions = {
              boot = {
                size = "500M";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  mountOptions = ["umask=0077"];
                };
              };
              main = {
                size = "100%";
                content = {
                  type = "lvm_pv";
                  vg = "main";
                };
              };
            };
          };
        };
      };
      lvm_vg = {
        main = {
          type = "lvm_vg";
          lvs = {
            root = {
              size = "25G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
                mountOptions = [
                  "defaults"
                ];
              };
            };
            nix = {
              size = "100G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/nix";
              };
            };
            log = {
              size = "25G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/var/log";
              };
            };
            lib = {
              size = "50G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/var/lib";
              };
            };
            k8s-data = {
              size = "50G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/var/lib/k8s-data";
              };
            };
            home = {
              size = "25G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/home";
                mountOptions = [
                  "defaults"
                ];
              };
            };
          };
        };
      };
    };
  };
}
