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

  # programs.neovim = {
  #   enable = true;
  #   extraPackages = with pkgs; [
  #     # LazyVim
  #     vue-language-server
  #     lua-language-server
  #     stylua
  #     # Telescope
  #     ripgrep
  #     # Most LSP need npm
  #     nodejs
  #   ];
  # };
}
