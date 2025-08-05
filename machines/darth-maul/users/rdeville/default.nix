{config, ...}: {
  sops = {
    age = {
      keyFile = "${config.xdg.cacheHome}/.age.key";
    };
    secrets = {
      "spotify-client-id" = {
        sopsFile = ../../../../common/secrets/spotify.enc.yaml;
      };
    };
  };

  nixpkgs = {
    config = {
      cudaSupport = true;
    };
  };

  hm = {
    userAccounts = [
      "contact@romaindeville.fr"
      "contact@romaindeville.ovh"
    ];

    flavors = {
      vscode.enable = true;
      bluetooth.enable = true;
    };
  };
}
