{
  config,
  lib,
  pkgs,
  ...
}: let
  name = builtins.baseNameOf ../.;
  subname = builtins.baseNameOf ./.;
  cfg = config.hm.flavors.${name}.${subname};
in {
  imports = [
    ./policies.nix
    ./profiles.nix
    ./policies.extensions.nix
  ];

  options = {
    hm = {
      flavors = {
        ${name} = {
          ${subname} = {
            enable =
              lib.mkDependEnabledOption ''
                Install ${name}.${subname} Home-Manager flavor.
              ''
              config.hm.flavors.${name}.enable;
            enableCustomCSS =
              lib.mkDependEnabledOption ''
                Enable my firefox custom CSS.
              ''
              config.hm.flavors.${name}.enable;
            configPath = lib.mkOption {
              type = lib.types.str;
              description = ''
                Path where to store firefox configuration
                '';
              default = lib.warn ''
                Using old programs.firefox.configPath. Set value to "${config.xdg.configHome}/mozilla/firefox" for new computer.
                Currently kept with older values since new values break firefox current configuration.
                '' ".mozilla/firefox";
            };
          };
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs = {
      firefox = {
        inherit (cfg)
        configPath;
        enable = true;
        package =
          if config.hm.isDarwin
          then pkgs.firefox-bin
          else pkgs.wrapFirefox (pkgs.firefox-unwrapped.override {pipewireSupport = true;}) {};
      };
    };
  };
}
