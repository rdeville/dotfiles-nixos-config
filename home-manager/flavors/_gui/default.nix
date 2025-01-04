{
  lib,
  hm,
  ...
}: let
  name = builtins.baseNameOf ./.;
in {
  imports =
    if hm ? flavors.${name}.enable && hm.flavors.${name}.enable
    then builtins.map (item: ./${item}) (lib.importDir ./.)
    else [];

  options = {
    hm = {
      flavors = {
        ${name} = {
          enable = lib.mkEnableOption "Install ${name} Home-Manager flavor.";
        };
      };
    };
  };
}
