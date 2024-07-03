{
  userCfg,
  pkgs,
  mkLib,
  ...
}: {
  programs = {
    fastfetch = {
      enable = true;
      package = mkLib.nixGLWrap pkgs.fastfetch userCfg;
      # settings = {
      #   "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
      #   logo = {
      #     type = "kitty";
      #     source = "$HOME/git/framagit.org/private/dotfiles/nixos/logo.png";
      #     width = 32;
      #   };
      #   modules = [
      #     "title"
      #     "separator"
      #     {
      #       type = "datetime";
      #       key = "Date";
      #       format = "{1}-{2}-{3}";
      #     }
      #   ];
      # };
    };
  };
}
