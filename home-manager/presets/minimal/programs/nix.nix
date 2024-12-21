{pkgs, ...}: {
  # Nix Package Manager Settings
  nix = {
    # Garbage Collection
    gc = {
      automatic = true;
      frequency = "weekly";
      options = "--delete-older-than 7d";
    };

    package = pkgs.nixVersions.latest;

    settings = {
      accept-flake-config = true;
      cores = 0;
      extra-experimental-features = [
        "flakes"
        "nix-command"
        "auto-allocate-uids"
      ];
      show-trace = true;
      trusted-users = [
        "root"
        "@wheel"
        "@sudo"
      ];
    };
  };
}
