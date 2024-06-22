{
  config,
  pkgs,
  cfg,
  ...
}: {
  microvm = {
    vcpu = cfg.vms.cpus;
    mem = cfg.vms.ram * 1024;
    graphics.enable = cfg.vms.graphics;
    writableStoreOverlay = "/nix/.rw-store";
    qemu = {
      extraArgs = [
        "-device"
        "virtio-gpu"
      ];
    };
    volumes = [
      {
        mountPoint = "/";
        image = "./../nixbox.qcow2";
        size = 20480;
      }
      {
        mountPoint = config.microvm.writableStoreOverlay;
        image = "./../nix.qcow2";
        size = 51200;
      }
      {
        mountPoint = "/nix";
        image = "./../nix-store.qcow2";
        size = 5120;
      }
    ];
    shares = [
      {
        proto = "9p";
        tag = "ro-store";
        source = "/nix/store";
        mountPoint = "/nix/.ro-store";
      }
      # {
      #   proto = "9p";
      #   tag = "nixos-config";
      #   source = "${builtins.getEnv "PWD"}/../../";
      #   target = "/home/nixos";
      #   securityModel = "mapped-file";
      # }
    ];

    hypervisor = "qemu";
    socket = "control.socket";
    interfaces = [
      {
        type = "user";
        id = "host";
        mac = "02:00:00:00:00:01";
      }
    ];
  };

  programs = {
    virt-manager = {
      enable = true;
    };
  };
}
