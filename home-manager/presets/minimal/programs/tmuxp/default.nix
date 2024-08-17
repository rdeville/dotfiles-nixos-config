{
  pkgs,
  config,
  ...
}: {
  home = {
    packages = with pkgs; [
      tmux # Shell Emulator
      tmuxp # Process and Ressource Manager
    ];
  };
  xdg = {
    configFile = {
      "tmuxp/default.yaml" = {
        enable = with pkgs; builtins.elem tmuxp config.home.packages;
        source = ./default.yaml;
      };
      "tmuxp/home.yaml" = {
        enable = with pkgs; builtins.elem tmuxp config.home.packages;
        source = ./home.yaml;
      };
    };
  };
}
