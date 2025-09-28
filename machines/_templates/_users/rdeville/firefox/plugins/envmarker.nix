{config, ...}: let
  profile =
    if config.hm.isWork
    then "pro"
    else "perso";
in {
  programs = {
    firefox = {
      profiles = {
        ${profile} = {
          extensions = {
            settings = {
              # Environment Marker
              "environmentmarker@example.com" = {
                force = true;
                settings = {
                  env_settings = let
                    env = {
                      "LOCAL TEKUNIX" = {
                        address = ".local.tekunix.cloud";
                        color = "rgba(0;255;0;0.25)";
                      };
                      "LOCAL" = {
                        address = ".local.romaindeville.xyz";
                        color = "rgba(128;255;0;0.25)";
                      };
                      "DEVELOPMENT TEKUNIX" = {
                        address = ".dev.tekunix.cloud";
                        color = "rgba(255;255;0;0.25)";
                      };
                      "DEVELOPMENT" = {
                        address = ".dev.romaindeville.xyz";
                        color = "rgba(255;255;0;0.25)";
                      };
                      "STAGING TEKUNIX" = {
                        address = ".stg.tekunix.cloud";
                        color = "rgba(255;128;0;0.25)";
                      };
                      "STAGING" = {
                        address = ".stg.romaindeville.xyz";
                        color = "rgba(255;128;0;0.25)";
                      };
                      "PRODUCTION TEKUNIX" = {
                        address = ".tekunix.cloud";
                        color = "rgba(255;0;0;0.25)";
                      };
                      "PRODUCTION" = {
                        address = ".romaindeville.xyz";
                        color = "rgba(255;0;0;0.25)";
                      };
                      "LOCALHOST" = {
                        address = "localhost";
                        color = "rgba(255;0;255;0.25)";
                      };
                    };
                  in
                    builtins.map (elem: let
                      cfg = env.${elem};
                    in {
                      name = elem;
                      address = cfg.address;
                      color = cfg.color;
                      fontSize = "20px";
                      position = "2";
                    }) (builtins.attrNames env);
                };
              };
            };
          };
        };
      };
    };
  };
}
