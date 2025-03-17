{
  inputs,
  config,
  ...
}: {
  nixpkgs = {
    overlays = [
      (
        final: prev: let
          pkgs = import inputs.overlay-terragrunt-2025-03-15 {
            inherit (config.nixpkgs) system;
          };
        in {
          terragrunt = pkgs.terragrunt;
        }
      )
    ];
  };
}
