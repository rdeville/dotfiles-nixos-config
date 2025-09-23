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
    ./tmuxp
    ./tmuxrc
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
        tmux # Terminal multiplexer
      ];
    };

    programs = {
      zsh = {
        zsh-abbr = {
          abbreviations = {
            # Tmux
            ta = "tmux attach -t";
            ts = "tmux switch-client -t";
            tls = "tmux list-sessions";
            tksv = "tmux kill-server";
            tkst = "tmux kill-session -t";
          };
        };
      };
    };
  };
}
