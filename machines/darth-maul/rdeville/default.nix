{
  config,
  pkgs,
  lib,
  ...
}: let
  keyFile = "${config.xdg.cacheHome}/.age.key";
in {
  imports = [
    ./hm.nix
  ];

  sops = {
    age = {
      inherit keyFile;
    };
    defaultSopsFile = ./secrets.enc.yaml;
    secrets = {
      "spotify-client-id" = {
        sopsFile = ../../../common_secrets/spotify.enc.yaml;
      };
    };
  };

  nixpkgs = {
    config = {
      allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) [
          "discord"
        ];
    };
  };

  xdg = {
    configFile = {
      "discord/settings.json" = {
        text = builtins.toJSON {
          SKIP_HOST_UPDATE = true;
        };
      };
    };
  };

  home = {
    shellAliases = {
      docker = "sudo docker";
    };

    packages = with pkgs; [
      discord
      inkscape
      hclfmt
      libreoffice
      luarocks-nix
      gimp
      ghostscript
      go
      (
        google-cloud-sdk.withExtraComponents [
          google-cloud-sdk.components.gke-gcloud-auth-plugin
        ]
      )
      google-cloud-sql-proxy
      signal-desktop
      ssh-to-age
      texliveFull
      terraform-docs
      terragrunt
      viddy
      whatsapp-for-linux
      yubikey-manager.out
    ];
  };
}
