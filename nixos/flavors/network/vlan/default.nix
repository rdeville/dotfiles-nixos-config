{
  config,
  lib,
  ...
}: let
  cfg = config.os.flavors.network;

  vlanNetwork = builtins.filter (elem: cfg.networks.${elem}.vlan.enable) (builtins.attrNames cfg.networks);
in {
  config = lib.mkIf (vlanNetwork != []) {
    systemd = {
      network = {
        netdevs = builtins.foldl' (acc: name: let
          interface = cfg.networks.${name};
        in
          {
            ${name} = {
              netdevConfig = {
                Kind = "vlan";
                Name = name;
              };
              vlanConfig = {
                Id = interface.vlan.id;
              };
            };
          }
          // acc) {}
        vlanNetwork;

        networks =
          builtins.foldl' (acc: name:
            {
              ${name} = {
                vlan =
                  builtins.filter (
                    interface:
                      (builtins.foldl' (acc: elem:
                        if (builtins.elem name cfg.networks.${interface}.vlan.vlanInterfaces)
                        then [
                          interface
                        ]
                        else
                          []
                          ++ acc) []
                      vlanNetwork)
                      != []
                  )
                  vlanNetwork;
              };
            }
            // acc) {}
          (
            builtins.foldl' (acc: elem:
              cfg.networks.${elem}.vlan.vlanInterfaces
              ++ acc) []
            vlanNetwork
          );
      };
    };
  };
}
