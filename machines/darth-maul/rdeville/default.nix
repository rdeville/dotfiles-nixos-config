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
          "terraform"
        ];
    };
  };

  home = {
    shellAliases = {
      docker = "sudo docker";
    };

    packages = with pkgs; [
      inkscape
      hclfmt
      libreoffice
      gimp
      ghostscript
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
      whatsapp-for-linux
      yubikey-manager
    ];
  };
}
