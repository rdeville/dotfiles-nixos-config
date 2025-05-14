{
  config,
  pkgs,
  lib,
  ...
}: let
  keyFile = "${config.xdg.cacheHome}/.age.key";
  user = "rdeville";
  hosts = [
    {
      name = "darth-plagueis";
      hostname = "romaindeville.ovh";
    }
    {
      name = "darth-vader";
      hostname = "romaindeville.fr";
    }
  ];
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
    userAccounts = [
      "contact@romaindeville.fr"
      "contact@romaindeville.ovh"
    ];

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

      ssh-client = {
        matchBlocks = builtins.foldl' (acc: elem: let
          key = "${user}-${config.hm.hostName}.pub";
        in
          {
            "${elem.name}" = {
              inherit user;
              hostname = elem.hostname;
              identitiesOnly = true;
              host = elem.name;
              identityFile = [
                "''\${HOME}/.ssh/pubkeys/${key}"
              ];
            };
          }
          // acc) {}
        hosts;
        file = builtins.foldl' (acc: elem: let
          key = "${user}-${config.hm.hostName}.pub";
        in
          {
            ".ssh/pubkeys/${key}" = {
              source = ../../../${config.hm.hostName}/${user}/_keys/${key};
            };
          }
          // acc) {}
        hosts;
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
