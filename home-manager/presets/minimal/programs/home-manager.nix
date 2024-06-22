{
  lib,
  pkgs,
  ...
}: {
  # Let Home Manager install and manage itself.
  programs = {
    home-manager = {
      enable = true;
    };
  };

  systemd = {
    user = {
      services = {
        home-manager-auto-upgrade = {
          Service = {
            # Force my own ExecStart as I use NixGL, must build/switch
            # home-manager with --impure args
            ExecStart =
              lib.mkForce
              (
                toString
                (pkgs.writeShellScript "home-manager-auto-upgrade" ''
                  echo "Update Nix's channels"
                  ${pkgs.nix}/bin/nix-channel --update
                  echo "Build Home Manager"
                  ${pkgs.home-manager}/bin/home-manager build --impure
                  echo "Upgrade Home Manager"
                  ${pkgs.home-manager}/bin/home-manager switch --impure
                '')
              );
          };
        };
      };
    };
  };

  services = {
    home-manager = {
      autoUpgrade = {
        enable = true;
        # Daily at 12:00
        frequency = "*-*-* 12:00";
      };
    };
  };
}
