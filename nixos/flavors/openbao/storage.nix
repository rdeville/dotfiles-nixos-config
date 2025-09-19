{lib, ...}: {
  options = {
    type = lib.mkOption {
      type = lib.types.enum ["raft"];
      description = "Type of backend storage";
      default = "raft";
    };

    raft = {
      node_id = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        description = ''
          The identifier for the node in the Raft cluster.
        '';
        default = null;
      };

      path = lib.mkOption {
        type = lib.types.str;
        description = ''
          Path where raft storage will storage its data.
        '';
        default = "/var/lib/openbao";
      };
    };
  };
}
