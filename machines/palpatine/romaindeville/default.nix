{
  config,
  pkgs,
  lib,
  ...
}: let
  username = builtins.baseNameOf ./.;

  base = import ../base.nix;
  default = import ../../default.nix {inherit username;};
  keyFile = "/home/rdeville/.cache/.age.key";
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
    defaultSopsFile = ./rdeville.enc.yaml;
    secrets = {
      "spotify-client-id" = {
        sopsFile = ../../../common_secrets/spotify.enc.yaml;
      };
    };
  };

  home = {
    packages = with pkgs; [
      hclfmt
      terragrunt
    ];
  };
}
