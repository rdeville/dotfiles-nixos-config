{
  accountsLib,
  hostname,
  username,
  ...
}: let
  default = import ../../default.nix;

  defaultHostCfg = import ../default.hostCfg.nix {inherit hostname;};

  userCfg = defaultHostCfg.mkDefaultUserCfg username;

  accounts = [
    "contact@romaindeville.fr"
    "contact@romaindeville.ovh"
  ];

  presets =
    default.hmPresets
    // {
      common.enable = true;
      main.enable = true;
      gui.enable = true;
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
      # My custom dotfiles
      awesomerc.enable = true;
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

  sops = {
    age = {
      keyFile = "/home/rdeville/.cache/.age.key";
    };
    defaultSopsFile = ./rdeville.enc.yaml;
    secrets =
      builtins.listToAttrs (
        builtins.map (address: {
          name = "accounts/${address}";
          value = {
            sopsFile = ../../../accounts/${address}/credentials.enc.yaml;
          };
        })
        accounts
      )
      // {
        "spotify-client-id" = {};
      };
  };

  accounts = import ../../../accounts/default.nix {
    userCfg =
      userCfg
      // {
        inherit presets;
      };
    inherit accountsLib accounts;
  };

  localFlavors = {
    bin.enable = true;
  };

  initialPassword = username;
  isNormalUser = true;
  extraGroupts = ["wheel"];
}
