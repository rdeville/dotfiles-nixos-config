{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  dateDelay = builtins.readFile (
    with pkgs;
      runCommand "date" {}
      "echo -n `date -d 'now - 7 days' +%Y-%m-%d` > $out"
  );
  overlayRegexp = "overlay-([a-zA-Z0-9_\.]*)-([0-9]{4}-[0-9]{2}-[0-9]{2})";
in {
  nixpkgs = {
    overlays =
      builtins.map (
        overlay: (
          final: prev: let
            overlayInfo = builtins.match overlayRegexp overlay;
            pkgOverlay = builtins.elemAt overlayInfo 0;
            dateOverlay = builtins.elemAt overlayInfo 1;
            pkgs = import inputs."${overlay}" {
              inherit (config.nixpkgs) system;
            };
          in {
            "${pkgOverlay}" = if dateOverlay > dateDelay
              then lib.mkWarn "Overlay ${overlay} hase more than one month" pkgs.${pkgOverlay}
              else pkgs.${pkgOverlay};
          }
        )
      ) (
        builtins.filter (
          inputName:
            (builtins.match overlayRegexp inputName) != null
        )
        (builtins.attrNames inputs)
      );
  };
}
