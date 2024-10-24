{hmLib, ...}: let
  accounts = [
    "contact@romaindeville.fr"
    "contact@romaindeville.ovh"
  ];
in {
  sudo = true;

  # sops = {
  #   age = {
  #     keyFile = "/home/rdeville/.cache/.age.key";
  #   };
  #   defaultSopsFile = ./rdeville.enc.yaml;
  #   secrets =
  #     (hmLib.mkAccountsSecrets accounts)
  #     // {
  #       "spotify-client-id" = {};
  #     };
  # };
  #
  # accounts = accounts;

  presets = {
    main = true;
    gui = true;
  };

  flavors = {
    bin.enable = true;
    gh.enable = true;
    glab.enable = true;
  };
}
