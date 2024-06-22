{cfg, ...}: {
  users = {
    users = builtins.listToAttrs (
      builtins.map (username: {
        name = "${username}";
        value = {
          isNormalUser = true;
          extraGroups = [
            "video"
            "audio"
            "camera"
            "lp"
            "scanner"
          ];
        };
      }) (builtins.attrNames cfg.users)
    );
  };
}
