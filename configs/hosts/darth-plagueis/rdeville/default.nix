{pkgs, ...}: let
  username = builtins.baseNameOf ./.;

  os = (import ../default.nix {}).os;
  default = import ../../default.nix {inherit username;};
  isGui =
    if os ? isGui
    then os.isGui
    else false;
  isMain =
    if os ? isMain
    then os.isMain
    else false;
in {
  extraConfig = {};

  hm = {
    inherit username isGui isMain;
    inherit (os) hostName;

    flavors = {
      _core =
        default.flavors._core
        // {
          starship = {
            modules = {
              sudo = {
                disable = true;
              };
            };
          };
        };
      _packages = {
        enable = true;
        pkgs = with pkgs; [
          hclfmt
          terraform-docs
          terragrunt
        ];
      };
      podman = {
        enable = true;
      };
      opentofu = {
        enable = true;
      };
      kubernetes-client = {
        enable = true;
      };
    };
  };
}
