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
          "zsh-abbr"
          "vscode"
          "vscode-extension-ms-vsliveshare-vsliveshare"
        ];
    };
  };

  home = {
    packages = with pkgs; [
      inkscape
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
      whatsapp-for-linux
      yubikey-manager
    ];
  };
}
