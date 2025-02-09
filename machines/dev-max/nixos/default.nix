{...}: let
  username = builtins.baseNameOf ./.;

  base = import ../base.nix;
in {
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  hm = {
    inherit username;
    inherit (base) hostName system;

    flavors = {
      _core = {
        enable = true;
      };

      _gui = {
        enable = true;
        wayland = {
          enable = true;
          hyprspace = {
            enable = false;
          };
        };
      };

      audio = {
        enable = true;
      };

      bluetooth = {
        enable = true;
      };

      discord = {
        enable = true;
      };

      gh = {
        enable = true;
      };

      glab = {
        enable = true;
      };

      kubernetes-client = {
        enable = true;
      };

      nextcloud-client = {
        enable = true;
      };

      ollama = {
        enable = false;
      };

      opentofu = {
        enable = true;
      };

      podman = {
        enable = true;
      };

      spotify-player = {
        enable = true;
      };

      ssh-client = {
        enable = true;
      };

      terraform = {
        enable = true;
      };

      vscode = {
        enable = false;
      };
    };
  };
}
