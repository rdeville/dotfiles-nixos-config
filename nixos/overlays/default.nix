{
  inputs,
  config,
  ...
}: let
  system = config.nixpkgs.hostPlatform;
  pkgs = inputs.nixos-stable.nixosModules.lib.pkgsForSystem system;
in {
  # nixpkgs = {
  #   overlays = [
  #     (
  #       final: prev: {
  #         terragrunt = pkgs.terragrunt;
  #       }
  #     )
  #   ];
  # };
}
