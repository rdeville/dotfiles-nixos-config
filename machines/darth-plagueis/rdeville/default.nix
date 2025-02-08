{
  lib,
  pkgs,
  ...
}: let
  username = builtins.baseNameOf ./.;
  base = import ../base.nix;
  default = import ../../default.nix {inherit username;};
in {
  home = {
    packages = with pkgs; [
      hclfmt
      terraform-docs
      terragrunt
    ];
  };

  hm = {
    inherit username;
    inherit (base) hostName system isMain;

    flavors = {
      inherit (default.flavors) _core;

      opentofu = {
        enable = true;
      };

      kubernetes-client = {
        enable = true;
      };
    };
  };
}
