{pkgs, ...}:
pkgs.stdenv.mkDerivation {
  name = "scripts";
  srcs = [
    ./.
  ];

  buildInputs = [
    pkgs.nix-output-monitor
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp ${pkgs.nix-output-monitor}/bin/nom $out/bin/nom
    cp -r lib $out/bin
    for file in *.sh; do
      bin=$(echo $file | ${pkgs.gnused}/bin/sed 's/\.sh$//g')
      cp $file $out/bin/$bin
    done
  '';
}
