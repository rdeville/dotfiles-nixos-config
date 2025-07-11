{config, ...}: {
  imports = [
    ./topology/darth-vader.nix
    ./topology/darth-plagueis.nix
    ./topology/illyse.nix
    ./topology/isp-router.nix
    ./topology/switch.nix
    ./topology/k8s-switch.nix
    ./topology/microvm.nix

    ./topology/p-wing.nix

    ./topology/lilith.nix
    ./topology/ava.nix
    ./topology/maya.nix
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
      config.lib.topology.mkInternet {
      };
  };

  networks = {
    internet = {
      name = "Internet";
      style = {
        primaryColor = "#d8f999";
        secondaryColor = null;
        pattern = "solid";
      };
    };
  };
}
