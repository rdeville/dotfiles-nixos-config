{
  userCfg,
  ...
}:
 {
  programs = {
    ssh = {
      enable = true;
      forwardAgent = true;
      hashKnownHosts = true;
      includes = ["~/.ssh/config.d/"];
    };
  };

  services = {
    ssh-agent = {
      enable = ! userCfg.isDarwin;
    };
  };
}
