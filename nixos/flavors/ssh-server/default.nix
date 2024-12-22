{
  config,
  lib,
  ...
}: let
  name = "ssh-server";
  cfg = config.os.flavors.${name};
in {
  options = {
    os = {
      flavors = {
        ${name} = {
          enable = lib.mkEnableOption "Install ssh-sserver related config";
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services = {
      openssh = {
        enable = true;
      };
    };
  };
}
