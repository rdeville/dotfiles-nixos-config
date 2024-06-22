{pkgs, ...}: {
  hardware = {
    pulseaudio = {
      enable = false;
    };
  };

  services = {
    # Sound
    pipewire = {
      enable = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
