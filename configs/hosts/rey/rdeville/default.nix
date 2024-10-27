{
  inputs,
  accountsLib,
  userCfg,
  ...
}: let
  mkLib = inputs.nixos.homeManagerModules.mkLib {inherit (inputs.nixos) inputs;};

  default = import ../../default.nix;

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
      # My custom programs
      dotgit-sync.enable = true;
    };

  git = {
    perso = default.git.perso;
  };
in {
  inherit (userCfg) stateVersion username hostname;
  inherit presets flavors git extraConfig;

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
    inherit mkLib accountsLib accounts;
  };

  # modules = [
  #   (
  #     {
  #       config,
  #       pkgs,
  #       ...
  #     }: {
  #       programs = {
  #         spotify-player = {
  #           settings = {
  #             client_id_command = pkgs.lib.mkForce "${pkgs.coreutils}/bin/cat ${config.sops.secrets.spotify-client-id.path}";
  #           };
  #         };
  #       };
  #     }
  #   )
  # ];
}
