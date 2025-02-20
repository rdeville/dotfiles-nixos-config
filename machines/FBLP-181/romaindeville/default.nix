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

  awesomerc = {
    enable = lib.mkForce false;
  };

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
      allowUnfree = true;
    };
  };

  programs = {
    kitty = {
      settings = {
        macos_option_as_alt = "left";
      };
    };
  };

  home = {
    packages = with pkgs; [
      viddy
      kind
      ghostscript
      (google-cloud-sdk.withExtraComponents [
        google-cloud-sdk.components.gke-gcloud-auth-plugin
      ])
      google-cloud-sql-proxy
      ssh-to-age
      terragrunt
      vaultwarden
      yubikey-manager.out
    ];
  };
}
