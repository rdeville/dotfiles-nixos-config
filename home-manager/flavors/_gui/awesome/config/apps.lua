return {
  terminal = "kitty" or "alacritty" or "xterm",
  editor = os.getenv("EDITOR") or "vim" or "vi" or "nano",
  gui_editor = os.getenv("GUI_EDITOR") or "code" or "gvim",
  browser = os.getenv("BROWSER") or "firefox" or "chromium-browser",
  explorer = "pcmanfm" or "thunar",
}
