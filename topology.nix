{config, ...}: let
  mkLib = config.lib.topology;
in {
  imports = [
    ./topology/darth-vader.nix
    ./topology/darth-plagueis.nix
    ./topology/illyse.nix
    ./topology/isp-router.nix
    ./topology/switch.nix
    ./topology/k8s-switch.nix

    ./topology/chewbacca.nix
    ./topology/han.nix
    ./topology/lando.nix
  ];

  renderers = {
    elk = {
      overviews = {
        services = {
          enable = false;
        };
      };
    };
  };

  nodes = {
    internet =
      mkLib.mkInternet {
      };
  };

  networks = {
    internet = {
      name = "Internet";
      style = {
        primaryColor = "#fe9a00";
        secondaryColor = null;
        pattern = "solid";
      };
    };
  };
}
