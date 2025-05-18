{...}: {
  sops = {
    secrets = {
      "spotify-client-id" = {
        sopsFile = ../../common_secrets/spotify.enc.yaml;
      };
    };
  };

  hm = {
    userAccounts = [
      "contact@romaindeville.fr"
      "contact@romaindeville.ovh"
    ];
  };
}
