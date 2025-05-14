{...}: {
  imports = [
    ../../_templates/_users/nixos/server.nix
    ../../_templates/_users/nixos/gui.nix
  ];

  hm = {
    username = builtins.baseNameOf ./.;
  };
}
