{
  config,
  osConfig,
  ...
}: {
  sops = {
    age = {
      keyFile = "${config.xdg.cacheHome}/.age.key";
    };
    secrets = {
      "spotify-client-id" = {
        sopsFile = ../../../../common_secrets/spotify.enc.yaml;
      };
    };
  };

  hm = {
    userAccounts = [
      "contact@romaindeville.fr"
      "contact@romaindeville.ovh"
    ];
    hostName = osConfig.networking.hostName;

    flavors = {
      vscode = {
        enable = true;
      };
    };
  };
}
