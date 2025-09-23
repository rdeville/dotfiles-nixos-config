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
    ./direnvrc
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
          };
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        direnv # Automated development tools
      ];
    };

    programs = {
      zsh = {
        initContent = lib.mkBefore ''
          source <(direnv hook zsh)
        '';

        zsh-abbr = {
          abbreviations = {
            da = "direnv allow";
            dr = "direnv reload";
            ds = "direnv status";
          };
        };
      };
    };
  };
}
