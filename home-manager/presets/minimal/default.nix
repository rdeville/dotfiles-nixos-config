{
  config,
  lib,
  hm,
  ...
}: let
  name = "minimal";
  cfg = config.hm.presets.${name};
in {
  imports =
    if hm ? presets.${name}.enable && hm.presets.${name}.enable
    then builtins.map (item: ./${item}) (lib.importDir ./.)
    else [];

  options = {
    hm = {
      presets = {
        ${name} = {
          enable = lib.mkEnableOption "Install ${name} Home-Manager presets.";
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    nixpkgs = {
      config = {
        allowUnfree = true;
      };
    };

    systemd = {
      user = {
        startServices = "sd-switch";
      };
    };
  };
}
