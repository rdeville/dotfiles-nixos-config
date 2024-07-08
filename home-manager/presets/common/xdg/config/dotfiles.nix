{
  config,
  pkgs,
  mkLib,
  ...
}: let
  repos = {
    "tmux" = {
      enable = with pkgs; builtins.elem tmux config.home.packages;
      # url = "/home/rdeville/git/framagit.org/rdeville-public/dotfiles/tmux";
      url = "https://framagit.org/rdeville-public/dotfiles/tmux";
      rev = "9fc631c6564492380e41c8f0d0a127232b67ac1e";
      ref = "main";
    };
    "tpm" = {
      enable = with pkgs; builtins.elem git config.home.packages;
      url = "https://github.com/tmux-plugins/tpm";
      rev = "99469c4a9b1ccf77fade25842dc7bafbc8ce9946";
      ref = "main";
    };
  };
in {
  xdg = {
    configFile = mkLib.mkRepos repos;
  };
}
