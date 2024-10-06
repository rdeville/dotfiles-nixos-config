{
  presets,
  lib,
  ...
}: let
  accounts = [
    "contact_at_romaindeville.fr"
    "contact_at_romaindeville.ovh"
  ];
in {
  home-manager = {
    xresources = {
      properties = {
        "Xft.dpi" = "97x96";
      };
    };
  };

  sops = {
    age = {
      keyFile = "/home/rdeville/.cache/.age.key";
    };
    defaultSopsFile = ./rdeville.enc.yaml;
    secrets =
      (lib.mkAccountsSecrets accounts)
      // {
        "spotify-client-id" = {};
      };
  };

  accounts = accounts;

  presets = presets;

  flavors = {
    bin = {
      enable = true;
    };
    bluetooth = {
      enable = true;
    };
    gh = {
      enable = true;
    };
    glab = {
      enable = true;
    };
    spotify-player = {
      enable = true;
      audio_backend = "pulseaudio";
    };
    terraform = {
      enable = true;
    };
    vscode = {
      enable = true;
    };
  };

  modules = [
    (
      {
        config,
        pkgs,
        ...
      }: {
        programs = {
          spotify-player = {
            settings = {
              client_id_command = pkgs.lib.mkForce "${pkgs.coreutils}/bin/cat ${config.sops.secrets.spotify-client-id.path}";
            };
          };
        };
      }
    )
  ];
}
