{lib, ...}: {
  options = {
    enable = lib.mkEnableOption "Enable wireguard interface";

    id = lib.mkOption {
      type = lib.types.int;
      description = "ID of the machine in the wireguard network.";
    };

    vlanInterfaces = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = "List of interfaces holding vlans";
      default = [];
    };
  };
}
