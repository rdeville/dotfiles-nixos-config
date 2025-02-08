{
  lib,
  modulesPath,
  pkgs,
  ...
}: let
  base = import ./base.nix;
in {
  imports = [
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
    ./os.nix
  ];

  networking = {
    useDHCP = lib.mkDefault true;
  };

  nixpkgs = {
    hostPlatform = base.system;
  };

  isoImage = {
    squashfsCompression = "gzip -Xcompression-level 1";
  };

  # Enable SSH in the boot process.
  systemd = {
    services = {
      sshd = {
        wantedBy = pkgs.lib.mkForce ["multi-user.target"];
      };
    };
  };

  hardware = {
    graphics = {
      enable = base.isGui;
    };
  };
}
