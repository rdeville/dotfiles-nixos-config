{
  config,
  lib,
  ...
}: let
  name = builtins.baseNameOf ./.;
  cfg = config.os.flavors.${name};
in {
  options = {
    os = {
      flavors = {
        ${name} = {
          enable = lib.mkEnable "Install ${name} NixOS flavors.";
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    homebrew = {
      enable = true;

      cask = [
        "docker"
      ];
    };
  };
}
