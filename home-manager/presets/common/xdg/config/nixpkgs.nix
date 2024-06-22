{
  config,
  pkgs,
  ...
}: {
  xdg = {
    configFile = {
      nixpkgs = {
        enable = true;
        text = ''
          {
            packageOverrides = pkgs: {
              nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
              inherit pkgs;
              };
            };
          }
        '';
        target = "nixpkgs/config.nix";
      };
    };
  };
}
