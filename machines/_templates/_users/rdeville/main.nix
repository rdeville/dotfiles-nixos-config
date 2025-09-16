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
        ghostscript
        slack
        ssh-to-age
        yubikey-manager
      ]
      ++ (
        if ! config.hm.isDarwin
        then [
          gimp3
          libreoffice
          signal-desktop-bin
          whatsapp-for-linux
        ]
        else []
      );
  };

  hm = {
    flavors = {
      _accounts.enable = true;
      _gui.enable = true;
      audio.enable = true;
      bluetooth.enable = true;
      discord.enable = true;
      docker.enable = true;
      gh.enable = true;
      glab.enable = true;
      kubernetes-client.enable = true;
      latex.enable = true;
      nextcloud-client.enable = true;
      opentofu.enable = true;
      terraform.enable = true;
      terragrunt.enable = true;

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
              inherit user;
              hostname = "romaindeville.fr";
              identitiesOnly = true;
              host = "darth-vader";
              identityFile = [
                "${config.home.homeDirectory}/.ssh/pubkeys/${userKey}"
              ];
            };
            "${user}@darth-plagueis" = {
              inherit user;
              hostname = "romaindeville.ovh";
              identitiesOnly = true;
              host = "darth-plagueis";
              identityFile = [
                "${config.home.homeDirectory}/.ssh/pubkeys/${userKey}"
              ];
            };
          }
          // (builtins.foldl' (acc: host: let
            azathothKey = "azathoth-${config.hm.hostName}.pub";
          in
            {
              "azathoth@${host}" = {
                inherit host;
                user = "azathoh";
                hostname = "${host}.tekunix.private";
                identitiesOnly = true;
                identityFile = [
                  "${config.home.homeDirectory}/.ssh/pubkeys/${azathothKey}"
                ];
              };
              "${user}@${host}" = {
                inherit user host;
                hostname = "${host}.tekunix.private";
                identitiesOnly = true;
                identityFile = [
                  "${config.home.homeDirectory}/.ssh/pubkeys/${userKey}"
                ];
              };
            }
            // acc) {}
          lib.getValidHosts);
        file = let
          key = "azathoth-${config.hm.hostName}.pub";
        in
          {
            ".ssh/pubkeys/${userKey}" = {
              source = ../../../${config.hm.hostName}/users/${user}/_keys/${userKey};
            };
          }
          // (
            if builtins.pathExists ../../../${config.hm.hostName}/users/azathoth/_keys/${key}
            then {
              ".ssh/pubkeys/${key}" = {
                source = ../../../${config.hm.hostName}/users/azathoth/_keys/${key};
              };
            }
            else {}
          );
      };
    };
  };

  dotgit-sync = {
    enable = true;
  };
}
