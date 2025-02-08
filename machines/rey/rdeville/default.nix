{
  config,
  pkgs,
  lib,
  ...
}: let
  keyFile = "/home/rdeville/.cache/.age.key";
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
    packages = with pkgs; [
      discord
      inkscape
      hclfmt
      libreoffice
      gimp
      ghostscript
      google-cloud-sdk
      google-cloud-sql-proxy
      signal-desktop
      texliveFull
      terraform-docs
      terragrunt
      whatsapp-for-linux
    ];
  };
}
