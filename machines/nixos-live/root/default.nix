{...}: {
  imports = [
    ../../_templates/_users/root/server.nix
  ];

  hm = {
    username = builtins.baseNameOf ./.;
  };
}
