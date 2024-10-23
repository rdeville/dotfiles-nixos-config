{hostCfg, ...}: {
  users = {
    users = builtins.listToAttrs (
      builtins.map (user: {
        name = "${user}";
        value = {
          extraGroups = [
            "video"
            "audio"
            "camera"
          ];
        };
      }) (builtins.attrNames hostCfg.users)
    );
  };
}
