# Source :
# https://francis.begyn.be/blog/nixos-home-router
# https://www.jjpdev.com/posts/home-router-nixos/
{...}: let
  iface = import ./_nets.nix;
in {
  networking = {
    useDHCP = false;
    # Physical Vlans
    vlans = builtins.foldl' (acc: interface:
      builtins.foldl' (acc: vlanName: let
        vlan = iface.net.${interface}.${vlanName};
      in
        {
          ${vlanName} = {
            inherit interface;
            inherit (vlan) id;
          };
        }
        // acc) {} (
        builtins.filter (
          vlanName: (vlanName != "enable" && iface.net.${interface}.${vlanName} ? id)
        ) (builtins.attrNames iface.net.${interface})
      )
      // acc) {} (builtins.attrNames iface.net);

    interfaces =
      # Physical Interfaces
      (
        builtins.foldl' (acc: ifaceName: let
          interface = iface.net.${ifaceName};
        in
          {
            ${ifaceName} =
              if interface ? useDHCP
              then {
                useDHCP = interface.useDHCP;
              }
              else if interface ? prefix && interface ? length
              then {
                ipv4 = {
                  addresses = [
                    {
                      address = "${interface.prefix}.1";
                      prefixLength = interface.length;
                    }
                  ];
                };
              }
              else {};
          }
          // acc) {} (builtins.attrNames iface.net)
      )
      //
      # Vlan Interfaces
      builtins.foldl' (acc: interface:
        builtins.foldl' (acc: vlanName: let
          vlan = iface.net.${interface}.${vlanName};
        in
          {
            ${vlanName} =
              if vlan ? prefix && vlan ? length
              then {
                ipv4.addresses = [
                  {
                    address = "${vlan.prefix}.1";
                    prefixLength = vlan.length;
                  }
                ];
              }
              else {};
          }
          // acc) {} (
          builtins.filter (
            vlanName: (vlanName != "enable" && iface.net.${interface}.${vlanName} ? id)
          ) (
            builtins.attrNames iface.net.${interface}
          )
        )
        // acc) {} (builtins.attrNames iface.net);
  };
}
