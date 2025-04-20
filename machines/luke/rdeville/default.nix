{...}: {
  imports = [
    ../../_templates/_users/rdeville/server.nix
  ];

  hm = {
    flavors = {
      kubernetes-client = {
        enable = true;
      };
    };
  };
}
