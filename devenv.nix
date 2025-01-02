# BEGIN DOTGIT-SYNC BLOCK MANAGED
{
  config,
  pkgs ? import <nixpkgs>,
  lib,
  # BEGIN DOTGIT-SYNC BLOCK EXCLUDED NIX_DEVENV_CUSTOM
  ...
}: let
  hm = ./scripts/hm.sh;
  os = ./scripts/nixos.sh;
  fmt = ./scripts/fmt.sh;
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
    os = {
      description = "Script acting as alias to NixOS";
      exec = ''
        ${os} "$@"
      '';
    };
    format = {
      description = "Nix format current directory";
      exec = ''
        ${fmt} "$@"
      '';
    };
  };
  # END DOTGIT-SYNC BLOCK EXCLUDED NIX_DEVENV_CUSTOM

  enterShell = ''
    CYAN="\033[36m"
    RESET="\033[0m"
    echo -e "$CYAN"
    echo -e "Helper scripts you can run to make your development richer:\n"
    ${pkgs.gnused}/bin/sed -e 's| |••|g' -e 's|=| |' <<EOF | ${pkgs.util-linuxMinimal}/bin/column -t | ${pkgs.gnused}/bin/sed -e 's|••| |g'
    ${lib.generators.toKeyValue {} (lib.mapAttrs (name: value: value.description) config.scripts)}
    EOF
    echo -e "$RESET"
  '';

  # Dotenv files are loading before devenv using direnv
  dotenv = {
    enable = false;
    disableHint = true;
  };
}
# END DOTGIT-SYNC BLOCK MANAGED
