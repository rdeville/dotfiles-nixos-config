{lib, ...}: {
  imports = [
    ../../_templates/_users/rdeville/server.nix
    ../../_templates/_users/rdeville/gui.nix
    ../../_templates/_users/rdeville/main.nix
  ];

  sops = {
    secrets = {
      "spotify-client-id" = {
        sopsFile = ../../../common_secrets/spotify.enc.yaml;
      };
    };
  };

  hm = {
    userAccounts = [
      "contact@romaindeville.fr"
      "contact@romaindeville.ovh"
    ];
    hostName = "darth-maul";

    flavors = {
      vscode = {
        enable = true;
      };
    };
  };
}
