{
  config,
  lib,
  pkgs,
  ...
}: let
  name = builtins.baseNameOf ./.;
  cfg = config.hm.flavors.${name};
in
  lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        # LazyVim
        lua-language-server
        stylua
        # Telescope
        ripgrep
        # Most LSP need npm
        nodejs
        # RustC for some lsp
        cargo
      ];
    };
  }
