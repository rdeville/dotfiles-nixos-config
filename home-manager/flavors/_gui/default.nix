{
  lib,
  pkgs,
  ...
}: let
  name = builtins.baseNameOf ./.;
in {
  imports = builtins.map (item: ./${item}) (lib.importDir ./.);

  options = {
    hm = {
      flavors = {
        ${name} = {
          enable = lib.mkEnableOption "Install ${name} Home-Manager flavor.";
          font = {
            name = lib.mkOption {
              type = lib.types.str;
              description = "Name of the default font to use in GUI.";
              default = "FiraCode Nerd Font";
            };
            size = lib.mkOption {
              type = lib.types.int;
              description = "Default font size applied to all GUI.";
              default = 14;
            };
            pkgs = lib.mkOption {
              type = lib.types.package;
              description = "Font pkgs to install.";
              default = pkgs.nerd-fonts.fira-code;
            };
          };
        };
      };
    };
  };
}
