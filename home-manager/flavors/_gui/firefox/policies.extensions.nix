{
  config,
  lib,
  ...
}: let
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

  addons = {
    # Sidebery
    sidebery = {
      shortId = "sidebery";
      uuid = "{3c078156-979c-498b-8990-85f7987dd929}";
    };
    # Antidote
    antidote = {
      shortId = "connecteur-pour-antidote";
      uuid = "antidote_uni10_firefox@druide.com";
    };
    # Colorize Container Toolbar - Light & Dark
    colorize-container-toolbar = {
      shortId = "colorize-container-toolbar";
      uuid = "{8645f5e1-2d18-480f-ae0b-67b39b1150c3}";
    };
    # Dark Reader
    dark-reader = {
      shortId = "darkreader";
      uuid = "addon@darkreader.org";
    };
    # Decentraleyes
    decentraleyes = {
      shortId = "decentraleyes";
      uuid = "jid1-BoFifL9Vbdl2zQ@jetpack";
    };
    # Firefox Multi-Account Containers
    multi-account-containers = {
      shortId = "multi-account-containers";
      uuid = "@testpilot-containers";
    };
    # I don't care about cookies
    i-dont-care-about-cookies = {
      shortId = "i-dont-care-about-cookies";
      uuid = "jid1-KKzOGWgsW3Ao4Q@jetpack";
    };
    # Location Guard
    location-guard = {
      shortId = "location-guard";
      uuid = "jid1-HdwPLukcGQeOSh@jetpack";
    };
    # NoScript
    noscript = {
      shortId = "noscript";
      uuid = "{73a6fe31-595d-460b-a920-fcc0f8843232}";
    };
    # Privacy Badger
    privay-badger = {
      shortId = "privacy-badger17";
      uuid = "jid1-MnnxcxisBPnSXQ@jetpack";
    };
    # Stylus
    stylus = {
      shortId = "styl-us";
      uuid = "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}";
    };
    # Tridactyl
    trydactyl = {
      shortId = "tridactyl-vim";
      uuid = "tridactyl.vim@cmcaine.co.uk";
    };
    # uBlock Origin
    ublock-origin = {
      shortId = "ublock-origin";
      uuid = "uBlock0@raymondhill.net";
    };
    # Environment Marker
    envmarker = {
      shortId = "environment-marker-extension";
      uuid = "environmentmarker@example.com";
    };
  };
in {
  options = {
    hm = {
      flavors = {
        ${name} = {
          ${subname} = {
            addons = builtins.foldl' (acc: elem:
              {
                "${elem}" = {
                  enable =
                    lib.mkDependEnabledOption ''
                      Enable ${elem} Add-on.
                    ''
                    config.hm.flavors.${name}.enable;
                };
              }
              // acc) {} (builtins.attrNames addons);
          };
        };
      };
    };
  };

  config = {
    programs = {
      firefox = {
        # See list of policies https://mozilla.github.io/policy-templates/
        policies = {
          # Use this nice project to get UUID : https://github.com/tupakkatapa/mozid
          # Or find source code and check firefox manifest
          ExtensionSettings = builtins.listToAttrs (
            builtins.foldl' (acc: elem: let
              elemCfg = addons.${elem};
            in
              [
                (extension elemCfg.shortId elemCfg.uuid)
              ]
              ++ acc) [] (builtins.filter (elem:
                cfg.addons.${elem}.enable == true) (builtins.attrNames addons))
          );
        };
      };
    };
  };
}
