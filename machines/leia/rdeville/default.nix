{...}: {
  imports = [
    ../../_templates/_users/rdeville/server.nix
  ];

  hm = {
    flavors = {
      bluetooth = {
        enable = true;
      };
    };
  };
}
