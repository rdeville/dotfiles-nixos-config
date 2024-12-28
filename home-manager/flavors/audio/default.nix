{
  config,
  lib,
  pkgs,
  ...
}: let
  name = builtins.baseNameOf ./.;
  cfg = config.hm.flavors.${name};

  linuxPkgs = with pkgs; [
    pipewire # Audio Server/Control
  ];
  darwinPkgs = [];
in {
  options = {
    hm = {
      flavors = {
        ${name} = {
          enable = lib.mkEnableOption "Install audio configuration";
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs;
        [
          # Audio
          pulseaudio # Audio Server/Control
          # TODO: @rdeville Change to another in few month as pulsemixer is not
          #       maintained anymore, like ncpamixer
          pulsemixer # TUI Audio Control
          # TODO: @rdeville Get info about pipewire and qpwgraph sometimes
          # qpwgraph        # Pipewire Graph Manager
        ]
        ++ (
          if config.hm.isDarwin
          then darwinPkgs
          else linuxPkgs
        );
    };
  };
}
