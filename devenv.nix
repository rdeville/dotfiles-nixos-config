{
  pkgs ? import <nixpkgs>,
  config,
  lib,
  ...
}: let
  hm = ./scripts/hm.sh;
  nixvm = ./scripts/nixvm.sh;
in {
  packages = with pkgs; [
    sops
    alejandra
  ];

  scripts = {
    hm = {
      description = "Script acting as alias to Home-Manager";
      exec = ''
        ${hm} "$@"
      '';
    };
    nixvm = {
      description = "Script allowing to run VM with nixos-shell or microvm";
      exec = ''
        ${nixvm}
      '';
    };
  };

  enterShell = ''
    CLR="\033[36m"
    RESET="\033[0m"
    echo -e "$CLR"
    echo -e "Helper scripts you can run to make your development richer:\n"
    ${pkgs.gnused}/bin/sed -e 's| |••|g' -e 's|=| |' <<EOF | ${pkgs.util-linuxMinimal}/bin/column -t | ${pkgs.gnused}/bin/sed -e 's|••| |g'
    ${lib.generators.toKeyValue {} (lib.mapAttrs (name: value: value.description) config.scripts)}
    EOF
    echo -e "$RESET"
  '';
}
