# {
#   config,
#   pkgs,
#   mkLib,
#   ...
# }: let
#   repos = {
#     "awesome" = {
#       enable = with pkgs; builtins.elem mr config.home.packages;
#       # url = "/home/rdeville/git/framagit.org/rdeville-public/dotfiles/myrepos";
#       url = "https://framagit.org/rdeville-public/dotfiles/awesome";
#       rev = "c31d77e81596054b727c37effc9e436d86f0874e";
#       ref = "main";
#     };
#   };
# in {
#   xdg = {
#     configFile = mkLib.mkRepos repos;
#   };
# }
{}
