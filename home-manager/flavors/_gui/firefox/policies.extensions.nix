{config, ...}: let
  name = builtins.baseNameOf ../.;
  subname = builtins.baseNameOf ./.;
  cfg = config.hm.flavors.${name}.${subname};

  extension = shortId: uuid: {
    name = uuid;
    value = {
      install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
      installation_mode = "normal_installed";
    };
  };
in {
  programs = {
    firefox = {
      # See list of policies https://mozilla.github.io/policy-templates/
      policies = {
        # Use this nice project to get UUID : https://github.com/tupakkatapa/mozid
        # Or find source code and check firefox manifest
        ExtensionSettings = builtins.listToAttrs ([
            # Antidote
            (extension "connecteur-pour-antidote" "antidote_uni10_firefox@druide.com")
            # Colorize Container Toolbar - Light & Dark
            (extension "colorize-container-toolbar" "{8645f5e1-2d18-480f-ae0b-67b39b1150c3}")
            # Dark Reader
            (extension "darkreader" "addon@darkreader.org")
            # Decentraleyes
            (extension "decentraleyes" "jid1-BoFifL9Vbdl2zQ@jetpack")
            # Firefox Multi-Account Containers
            (extension "multi-account-containers" "@testpilot-containers")
            # I don't care about cookies
            (extension "i-dont-care-about-cookies" "jid1-KKzOGWgsW3Ao4Q@jetpack")
            # Location Guard
            (extension "location-guard" "jid1-HdwPLukcGQeOSh@jetpack")
            # NoScript
            (extension "noscript" "{73a6fe31-595d-460b-a920-fcc0f8843232}")
            # Privacy Badger
            (extension "privacy-badger17" "jid1-MnnxcxisBPnSXQ@jetpack")
            # Stylus
            (extension "styl-us" "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}")
            # Tridactyl
            (extension "tridactyl-vim" "tridactyl.vim@cmcaine.co.uk")
            # uBlock Origin
            (extension "ublock-origin" "uBlock0@raymondhill.net")
            # Environment Marker
            (extension "environment-marker-extension" "environmentmarker@example.com")
          ]
          ++ (
            if cfg.enableSidebery
            then [
              # Sidebery
              (extension "sidebery" "{3c078156-979c-498b-8990-85f7987dd929}")
            ]
            else []
          ));
      };
    };
  };
}
