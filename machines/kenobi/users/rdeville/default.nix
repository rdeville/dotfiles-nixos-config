{config, ...}: let
  keyFile = "${config.xdg.cacheHome}/.age.key";
in {
  sops = {
    age = {
      inherit keyFile;
    };
    secrets = {
      "spotify-client-id" = {
        sopsFile = ../../../../common/secrets/spotify.enc.yaml;
      };
    };
  };

  hm = {
    flavors = {
      bluetooth = {
        enable = true;
      };
    };
  };
}
