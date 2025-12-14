_: {
  isoImage = {
    squashfsCompression = "gzip -Xcompression-level 1";
  };

  virtualisation = {
    vmVariant = {
      # Taken from https://github.com/donovanglover/nix-config/commit/0bf134297b3a62da62f9ee16439d6da995d3fbff
      # to enable Hyprland to work on a virtualized GPU.
      virtualisation = {
        cores = 2;
        memorySize = 4096;
      };
    };
  };
}
