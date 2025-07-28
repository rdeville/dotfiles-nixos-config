{
  inputs,
  lib,
  pkgs,
  ...
}: let
  dateDelay = builtins.readFile (
    with pkgs;
      runCommand "date" {}
      "echo -n `date -d 'now - 1 months' +%Y-%m-%d` > $out"
  );
  # Structure : overlay-<pkgName>-<YYYY-MM-DD>
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
            newPkgs = import inputs."${overlay}" {
              inherit (pkgs) system;
            };
          in {
            "${pkgOverlay}" =
              if dateDelay > dateOverlay
              then lib.mkWarn "Overlay ${overlay} hase more than one month" newPkgs.${pkgOverlay}
              else newPkgs.${pkgOverlay};
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
