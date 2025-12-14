_: let
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
        enable = false;
      };

      _gui = {
        enable = false;
        wayland = {
          enable = false;
        };
      };

      audio = {
        enable = false;
      };

      bluetooth = {
        enable = false;
      };

      discord = {
        enable = false;
      };

      gh = {
        enable = false;
      };

      glab = {
        enable = false;
      };

      kubernetes-client = {
        enable = false;
      };

      nextcloud-client = {
        enable = false;
      };

      ollama = {
        enable = false;
      };

      opentofu = {
        enable = false;
      };

      podman = {
        enable = false;
      };

      spotify-player = {
        enable = false;
      };

      ssh-client = {
        enable = false;
      };

      terraform = {
        enable = false;
      };

      vscode = {
        enable = false;
      };
    };
  };
}
