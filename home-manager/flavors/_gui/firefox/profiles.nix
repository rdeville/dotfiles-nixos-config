{
  config,
  pkgs,
  lib,
  ...
}: let
  name = builtins.baseNameOf ../.;
  subname = builtins.baseNameOf ./.;
  cfg = config.hm.flavors.${name}.${subname};

  nixIcon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
  hidden = {
    metaData = {
      hidden = true;
    };
  };
  alias = alias: {
    metaData = {
      inherit alias;
    };
  };
  engines = {
    "DuckDuckGo NoAI" = {
      urls = [
        {
          template = "https://noai.duckduckgo.com/";
          params = [
            {
              name = "q";
              value = "{searchTerms}";
            }
          ];
        }
      ];
      definedAliases = ["@ddg" "@d" "ddg" "d"];
    };
    "Nix Packages" = {
      urls = [
        {
          template = "https://mynixos.com/search";
          params = [
            {
              name = "q";
              value = "{searchTerms}";
            }
          ];
        }
      ];
      icon = nixIcon;
      definedAliases = ["@np" "np"];
    };
    "Home Manager" = {
      urls = [
        {
          template = "https://home-manager-options.extranix.com/";
          params = [
            {
              name = "query";
              value = "{searchTerms}";
            }
            {
              name = "release";
              value = "master";
            }
          ];
        }
      ];
      icon = nixIcon;
      definedAliases = ["@hm" "hm"];
    };
  };
  settings = {
    "browser.backspace_action" = 0;
    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
  };
  search = {
    # DuckDuckGo
    default = "DuckDuckGo NoAI";
    privateDefault = "DuckDuckGo NoAI";
    engines =
      engines
      // {
        # DuckDuckGo
        "ddg" = hidden;
        "bing" = hidden;
        "qwant" = hidden;
        "perplexity" = hidden;
        "google" = alias "g";
        "wikipedia (en)" = alias ":w";
        "bookmarks" = alias ":b";
        "tabs" = alias ":t";
        "history" = alias ":h";
      };
    force = true;
    order = [
      "DuckDuckGo NoAI"
      "wikipedia"
      "Nix Packages"
      "Home Manager"
      "google"
    ];
  };
  userChrome = if config.hm.isDarwin
  then builtins.readFile ./chrome/userChrome.darwin.css else
builtins.readFile ./chrome/userChrome.css ;
in {
  config = lib.mkIf cfg.enable {
    programs = {
      firefox = {
        profiles =
          if config.hm.isWork
          then {
            pro =
              {
                id = 0;
                isDefault = config.hm.isWork;
                name = "pro";
                userContent = "";
                settings = settings // {};
                inherit
                  search
                  ;
              }
              // (
                if cfg.enableCustomCSS
                then {
                  inherit userChrome;
                }
                else {}
              );
          }
          else {
            perso =
              {
                id = 0;
                isDefault = ! config.hm.isWork;
                name = "perso";
                userContent = "";
                settings = settings // {};
                inherit
                  search
                  ;
              }
              // (
                if cfg.enableCustomCSS
                then {
                  inherit userChrome;
                }
                else {}
              );
          };
      };
    };
  };
}
