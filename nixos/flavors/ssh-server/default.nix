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
          enable = lib.mkEnableOption "Install ${name} NixOS flavors.";
          ports = lib.mkOption {
            type = lib.types.listOf lib.types.port;
            default = [22];
            description = "Specifies on which ports the SSH daemon listens.";
          };
          openFirewall = lib.mkOption {
            type = lib.types.bool;
            description = "Whether to automatically open the specified ports in the firewall.";
            default = false;
          };
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services = {
      openssh = {
        inherit (cfg) ports;
        enable = true;
        openFirewall =
          if ! cfg.openFirewall
          then lib.warn "OpenSSH server enable but firewall won't be open" cfg.openFirewall
          else cfg.openFirewall;
      };
    };
  };
}
