{
  config,
  pkgs,
  lib,
  ...
}: let
  user = config.hm.username;
  keyFile = "${config.xdg.cacheHome}/.age.key";
in {
  sops = {
    age = {
      inherit keyFile;
    };
  };

  home = {
    packages = with pkgs;
      [
        inkscape
        gimp
        ghostscript
        slack
        ssh-to-age
        yubikey-manager
      ]
      ++ (
        if ! config.hm.isDarwin
        then [
          libreoffice
          signal-desktop-bin
          whatsapp-for-linux
        ]
        else []
      );
  };

  hm = {
    flavors = {
      _accounts = {
        enable = true;
      };

      _gui = {
        enable = true;
      };

      audio = {
        enable = true;
      };

      bluetooth = {
        enable = true;
      };

      discord = {
        enable = true;
      };

      docker = {
        enable = true;
      };

      gh = {
        enable = true;
      };

      glab = {
        enable = true;
      };

      kubernetes-client = {
        enable = true;
      };

      latex = {
        enable = true;
      };

      nextcloud-client = {
        enable = true;
      };

      opentofu = {
        enable = true;
      };

      spotify-player = {
        enable = true;
        client_id_command = lib.strings.concatStringsSep " " [
          "${pkgs.coreutils}/bin/cat"
          "${config.xdg.configHome}/sops-nix/secrets/spotify-client-id"
        ];
      };

      ssh-client = let
        userKey = "${user}-${config.hm.hostName}.pub";
      in {
        matchBlocks =
          {
            "${user}@darth-vader" = {
              user = user;
              hostname = "romaindeville.fr";
              identitiesOnly = true;
              host = "darth-vader";
              identityFile = [
                "$HOME/.ssh/pubkeys/${userKey}"
              ];
            };
            "${user}@darth-plagueis" = {
              user = user;
              hostname = "romaindeville.ovh";
              identitiesOnly = true;
              host = "darth-plagueis";
              identityFile = [
                "$HOME/.ssh/pubkeys/${userKey}"
              ];
            };
          }
          // (builtins.foldl' (acc: host: let
            key = "azathoth-${config.hm.hostName}.pub";
          in
            {
              "azathoth@${host}" = {
                inherit host;
                user = "azathoh";
                hostname = "${host}.tekunix.internal";
                identitiesOnly = true;
                identityFile = [
                  "$HOME/.ssh/pubkeys/${key}"
                ];
              };
              "${user}@${host}" = {
                inherit host;
                user = "azathoh";
                hostname = "${host}.tekunix.internal";
                identitiesOnly = true;
                identityFile = [
                  "$HOME/.ssh/pubkeys/${key}"
                ];
              };
            }
            // acc) {}
          lib.getValidHosts);
        file =
          {
            ".ssh/pubkeys/${userKey}" = {
              source = ../../../${config.hm.hostName}/${user}/_keys/${userKey};
            };
          }
          // (builtins.foldl' (acc: host: let
            key = "azathoth-${config.hm.hostName}.pub";
          in
            {
              ".ssh/pubkeys/${key}" = {
                source = ../../../${config.hm.hostName}/azathoth/_keys/${key};
              };
            }
            // acc) {}
          lib.getValidHosts);
      };

      terraform = {
        enable = true;
      };

      terragrunt = {
        enable = true;
      };
    };
  };
}
