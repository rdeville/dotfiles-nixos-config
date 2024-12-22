let
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
        ExtensionSettings = builtins.listToAttrs [
          # Antidote
          (extension "connecteur-pour-antidote" "antidote_uni10_firefox@druide.com")
          # Container Color Toolbar
          (extension "container-color-toolbar" "{293bcb6f-b811-4f9b-a79e-281653ff07b8}")
          # Containerise
          (extension "containerise" "containerise@kinte.sh")
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
          # Sidebery
          (extension "sidebery" "{3c078156-979c-498b-8990-85f7987dd929}")
          # Stylus
          (extension "styl-us" "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}")
          # Temporary Containers
          (extension "temporary-containers" "{c607c8df-14a7-4f28-894f-29e8722976af}")
          # Tridactyl
          (extension "tridactyl-vim" "tridactyl.vim@cmcaine.co.uk")
          # uBlock Origin
          (extension "ublock-origin" "uBlock0@raymondhill.net")
        ];
      };
    };
  };
}
