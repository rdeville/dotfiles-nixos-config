{lib, ...}: {
  options = {
    enable = lib.mkEnableOption "Enable wireguard interface";

    id = lib.mkOption {
      type = lib.types.int;
      description = "ID of the machine in the wireguard network.";
    };

    internetInterfaces = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = ''
        If `allowInternet` is set to `true`, specify the output interfaces to
        which forward packets.
      '';
      default = [];
    };

    privateKeyFile = lib.mkOption {
      type = lib.types.path;
      description = ''
        Path to the private key files for the wireguard interfaces.
      '';
    };

    listenPort = lib.mkOption {
      type = lib.types.nullOr lib.types.int;
      description = ''
        Port on which wireguard server will listen to.
        If not specify, will use a random port.

        If boolean `isServer` is set to `true` this attributes is
        required.
      '';
      default = null;
    };

    listenInterfaces = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = ''
        List of interfaces that will listen for wireguard
        connection.

        If boolean `isServer` is set to `true` this attributes is
        required.
      '';
      default = [];
    };

    peers = lib.mkOption {
      type = lib.types.listOf (lib.types.submodule {
        options = {
          AllowedIPs = lib.mkOption {
            type = lib.types.str;
            description = ''
              String of AllowedIPs for the wireguard interfaces.
            '';
            default = "";
          };

          PublicKey = lib.mkOption {
            type = lib.types.either lib.types.str lib.types.path;
            description = ''
              PublicKey of the peers allowed to connect to wireguard.
            '';
          };

          Endpoint = lib.mkOption {
            type = lib.types.nullOr lib.types.str;
            description = ''
              Entpoint of server to which wireguard should connect to of the form
            '';
            default = null;
          };
        };
      });
      default = [];
    };
  };
}
