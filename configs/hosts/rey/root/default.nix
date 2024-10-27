{userCfg, ...}: let
  default = import ../../default.nix;

  presets =
    default.hmPresets
    // {
      common.enable = true;
      main.enable = true;
    };

  flavors =
    default.hmFlavors
    // {
      gh.enable = true;
      glab.enable = true;
    };

  extraConfig =
    default.hmExtraConfig
    // {
      # My custom programs
      dotgit-sync.enable = true;
    };

  git = {
    perso = default.git.perso;
  };
in {
  inherit (userCfg) stateVersion username hostname;
  inherit presets flavors extraConfig git;

  sudo = true;
  home = "/root";

  localFlavors = {
    bin.enable = true;
  };
}
