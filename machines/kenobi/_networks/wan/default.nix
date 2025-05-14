# Source :
# https://labs.quansight.org/blog/2020/07/nixos-rpi-wifi-router
{...}: let
  lanDevice = "enp3s0";
  lanIface = lanDevice;
in {
  networking = {
    # Physical and virtual Interface
    interfaces = {
      ${lanIface} = {
        useDHCP = true;
      };
    };

    # firewall = {
    #   interfaces = {
    #     "${lanIface}" = {
    #       allowedUDPPorts = [
    #         # DNS Port
    #         53
    #         # DHCP Port
    #         67
    #       ];
    #     };
    #   };
    # };

    nftables = {
      ruleset = builtins.readFile ./config.nftables;
    };
  };
}
