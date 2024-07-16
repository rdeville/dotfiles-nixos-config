{
  ...
}: {
  xdg = {
    configFile = {
      terraform = {
        enable = true;
        target = "terraform/terraformrc";
        text = ''
          plugin_cache_dir = "$HOME/.cache/terraform/plugins"
        '';
      };
    };
  };
}
