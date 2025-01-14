{
  config,
  pkgs,
  lib,
  ...
}: let
  username = builtins.baseNameOf ./.;

  base = import ../base.nix;
  default = import ../../default.nix {inherit username;};
  keyFile = "/home/rdeville/.cache/.age.key";
in {
  awesomerc = {
    enable = lib.mkForce false;
  };

  sops = {
    age = {
      keyFile = "/home/rdeville/.cache/.age.key";
    };
    defaultSopsFile = ./rdeville.enc.yaml;
    secrets = {
      "spotify-client-id" = {
        sopsFile = ./rdeville.enc.yaml;
      };
    };
  };

  hm = {
    inherit username;
    inherit (base) hostName system isGui isMain isDarwin;

    nixpkgs = {
      allowUnfree = true;
    };

    flavors = {
      _core =
        default.flavors._core
        // {
          git = {
            # TODO: @rdeville: Update path below in function of the company
            # repo structure
            # pro = {
            #   condition = "gitdir:${config.home.homeDirectory}./git";
            #   contents = {
            #     commit = {
            #       gpgSign = false;
            #     };
            #     push = {
            #       gpgSign = "if-asked";
            #     };
            #     tag = {
            #       forceSignAnnotated = true;
            #       gpgSign = false;
            #     };
            #     user = {
            #       name = "Romain Deville";
            #       email = "CHANGE@ME.tld";
            #     };
            #   };
            # };
          };
        };
      _accounts = {
        enable = base.isMain;
      };
      _gui = {
        enable = base.isGui;
      };
      _packages = {
        enable = true;
        pkgs = with pkgs; [
          viddy
          hclfmt
          terragrunt
        ];
      };
      # TODO: @rdeville: Update below activated flavors in function of needed
      # tools on my professional workstation
      gh = {
        enable = false;
      };
      glab = {
        enable = false;
      };
      kubernetes-client = {
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
        enable = true;
      };
      terraform = {
        enable = true;
      };
    };
  };
}
