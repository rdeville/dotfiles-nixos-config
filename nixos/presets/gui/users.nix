{cfg, ...}: {
  users = {
    users = builtins.listToAttrs (
      builtins.map (username: {
        name = "${username}";
        value = {
          isNormalUser = true;
          extraGroups = [
            "video"
            "camera"
          ];
        };
      }) (builtins.attrNames cfg.users)
    );
  };
}
