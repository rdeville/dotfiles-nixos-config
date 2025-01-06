{
  lib,
  ...
}: let
  name = builtins.baseNameOf ./.;
in {
  imports =builtins.map (item: ./${item}) (lib.importDir ./.);

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
