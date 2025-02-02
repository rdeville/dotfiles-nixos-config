{
  config,
  pkgs ? import <nixpkgs>,
  lib,
  ...
}: let
  scriptsDetails = {
    hm = "Manage Home-Manager config";
    iso = "Manage NixOS ISO config";
    os = "Manage NixOS config";
    vm = "Manage NixOS VMs config";
  };

  scripts = builtins.foldl' (acc: elem:
    {
      "${elem}" = {
        description = scriptsDetails.${elem};
        exec = ''${./scripts/${elem}.sh} "$@"'';
      };
    }
    // acc) {} (builtins.attrNames scriptsDetails);
in {
  packages = with pkgs; [
    sops
    alejandra
  ];

  inherit scripts;

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
