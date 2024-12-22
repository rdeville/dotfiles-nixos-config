{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      tmuxp # Tmux Manager
    ];
  };

  xdg = {
    configFile = {
      "tmuxp/default.yaml" = {
        enable = true;
        source = ./default.yaml;
      };
      "tmuxp/home.yaml" = {
        enable = true;
        source = ./home.yaml;
      };
    };
  };
}
