{lib, ...}: let
  name = builtins.baseNameOf ./.;
in {
  imports = [
    ./neomutt
    ./notmuch
    ./khal.nix
    ./khard.nix
    ./mbsync.nix
    ./vdirsyncer.nix
  ];

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
