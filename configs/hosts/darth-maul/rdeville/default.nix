{
  inputs,
  accountsLib,
  system,
  hostname,
  username,
  ...
}: let
  default = import ../../default.nix {
    inherit inputs accountsLib system hostname;
  };

  userCfg = default.mkDefaultUserCfg username;

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
      bluetooth.enable = true;
      gh.enable = true;
      glab.enable = true;
      nextcloud-client.enable = true;
      container.enable = true;
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

  programs = {
    kitty = {
      settings = {
        font_size = "12.0";
        active_tab_foreground = "#212121";
        active_tab_background = "#388E3C";
      };
    };
  };
in {
  inherit (userCfg) stateVersion username hostname system isDarwin wrapGL;
  inherit presets flavors extraConfig git programs;

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
