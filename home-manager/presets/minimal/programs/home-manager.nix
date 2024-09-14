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
            Environment = [
              "DISPLAY=:0"
            ];
            # Force my own ExecStart as I use NixGL, must build/switch
            # home-manager with --impure args
            ExecStart =
              lib.mkForce
              (
                toString
                (pkgs.writeShellScript "home-manager-auto-upgrade" ''
                  notify(){
                    local title="HM Auto Upgrade"
                    local level="normal"
                    if [[ -n "$2" && "$2" == 0 ]]; then
                      title+=" Success"
                    elif [[ -n "$2" && "$2" == 1 ]]; then
                      title+=" Failed"
                      level="critical"
                    fi
                    notify-send -u "''${level}" "''${title}" "$1"
                  }

                  notify "Update Nix's channels"
                  if ! ${pkgs.nix}/bin/nix-channel --update; then
                    notify "Failed to update Nix's channels!" 1
                  fi

                  notify "Build Home Manager"
                  if ! $HOME/.nix-profile/bin/home-manager build --impure; then
                    notify "Failed to Build Home Manager Config!" 1
                    return 1
                  fi

                  notify "Switch Home Manager"
                  if ! $HOME/.nix-profile/bin/home-manager switch --impure; then
                    notify "Failed to Switch Home Manager Config!" 1
                    return 1
                  fi

                  notify "Switch Success" 0
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
