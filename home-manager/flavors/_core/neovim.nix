{pkgs, ...}: {
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
