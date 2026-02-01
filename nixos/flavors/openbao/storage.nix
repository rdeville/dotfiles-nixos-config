{lib, ...}: {
  options = {
    type = lib.mkOption {
      type = lib.types.enum [
        "raft"
        "postgresql"
      ];
      description = "Type of backend storage";
      default = "raft";
    };

    raft = lib.mkOption {
      type = lib.types.submodule {
        options = {
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
      description = "Configuration of the raft storage";
      default = {};
    };

    postgresql = lib.mkOption {
      type = lib.types.submodule {
        options = {
          connection = lib.mkOption {
            default = {};
            description = ''
              default = {};
                Set of connection parameter that will be set as environment
                variables. See [Environment Variables](https://www.postgresql.org/docs/current/libpq-envars.html)
                for more details.
            '';
            type = lib.types.submodule {
              options = {
                host = lib.mkOption {
                  type = lib.types.nullOr lib.types.str;
                  description = "Name of the host to connect to";
                  default = null;
                  # default = "localhost";
                };

                port = lib.mkOption {
                  type = lib.types.nullOr lib.types.int;
                  description = "Port number to connect to at the server host";
                  default = null;

                  # default = 5432;
                };

                database = lib.mkOption {
                  type = lib.types.nullOr lib.types.str;
                  description = "The database name";
                  default = null;
                  # default = "openbao";
                };

                user = lib.mkOption {
                  type = lib.types.nullOr lib.types.str;
                  description = "PostgreSQL user name to connect as";
                  default = null;
                  # default = "openbao";
                };

                password = lib.mkOption {
                  type = lib.types.nullOr lib.types.str;
                  description = ''
                    Specify the password for the user
                  '';
                  default = null;
                };

                sslmode = lib.mkOption {
                  type = lib.types.nullOr lib.types.str;
                  description = ''                    Determines whether or with what priority a
                                      secure SSL TCP/IP connection will be negotiated with the
                                      server.
                  '';
                  default = null;
                };
              };
            };
          };

          table = lib.mkOption {
            type = lib.types.str;
            description = ''
              Specifies the name of the table in which to write OpenBao data. OpenBao will
              attempt to create it if missing and skip_create_table=false (the default).
            '';
            default = "kv_store";
          };

          max_idle_connections = lib.mkOption {
            type = lib.types.int;
            description = ''
              Sets the maximum number of connections in the idle connection pool.
            '';
            default = 0;
          };

          max_parallel = lib.mkOption {
            type = lib.types.str;
            description = ''
              Specifies the maximum number of concurrent requests to PostgreSQL.
            '';
            default = "128";
          };

          ha_enabled = lib.mkOption {
            type = lib.types.bool;
            description = ''
              Default not enabled, requires PostgreSQL 9.5 or later.
            '';
            default = false;
          };

          ha_table = lib.mkOption {
            type = lib.types.str;
            description = ''
              Specifies the name of the table to use for storing High Availability
              information. OpenBao will attempt to create it if missing and
              skip_create_table=false (the default).
            '';
            default = "openbao_ha_locks";
          };

          skip_create_table = lib.mkOption {
            type = lib.types.bool;
            description = ''
              When enabled, will not attempt to automatically create database tables if
              missing. Set to true if the database user does not have the required
              permissions; otherwise, OpenBao will fail to start.
            '';
            default = false;
          };

          max_connect_retries = lib.mkOption {
            type = lib.types.int;
            description = ''
              Maximum number of retries to perform when waiting for the database to be
              active.
            '';
            default = 1;
          };
        };
      };
      description = "Configuration of the postgresql storage";
      default = {};
    };
  };
}
