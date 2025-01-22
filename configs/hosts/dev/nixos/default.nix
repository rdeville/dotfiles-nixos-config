{...}: let
  username = builtins.baseNameOf ./.;

  base = import ../base.nix;
in {
  hm = {
    inherit username;
    inherit (base) hostName system;

    flavors = {
      _core = {
        enable = true;
      };
      _gui = {
        enable = base.isGui;
      };
      audio = {
        enable = false;
      };
      bluetooth = {
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
