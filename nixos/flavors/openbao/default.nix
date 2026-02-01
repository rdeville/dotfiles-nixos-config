{
  config,
  lib,
  pkgs,
  ...
}: let
  name = builtins.baseNameOf ./.;
  cfg = config.os.flavors.${name};

  settingsFormat = pkgs.formats.json {};
  pgEnvVar =
    if cfg.storage.type == "postgresql"
    then let
      conn = cfg.storage.postgresql.connection;
    in
      builtins.foldl' (acc: elem:
        {
          "PG${lib.strings.toUpper elem}" = toString conn.${elem};
        }
        // acc) {}
      (
        (builtins.filter (item: conn.${item} != null)) (builtins.attrNames conn)
      )
    else null;
  listener = builtins.foldl' (acc: name: let
    listenerCfg = cfg.listeners.${name};
  in
    [
      (
        {
          inherit (listenerCfg) type;
          address =
            if listenerCfg.interface != null
            then let
              address = builtins.elemAt config.os.flavors.network.networks.${listenerCfg.interface}.address 0;
              ip = builtins.elemAt (lib.strings.splitString "/" address) 0;
            in "${ip}:${toString listenerCfg.port}"
            else "${listenerCfg.ip}:${toString listenerCfg.port}";
          disable_unauthed_rekey_endpoints = listenerCfg.disableUnauthedRekeyEndpoints;
          custom_response_headers = let
            res = listenerCfg.customResponseHeaders;
          in {
            default = res.default // res.extraDefault;
          };
        }
        // (
          if listenerCfg.tlsDisable
          then {
            tls_disable = listenerCfg.tlsDisable;
          }
          else if listenerCfg.tlsCertFile == ""
          then {
            tls_acme_ca_directory = listenerCfg.tlsAcmeCaDirectory;
            tls_acme_domains = listenerCfg.tlsAcmeDomains;
            tls_acme_email = listenerCfg.tlsAcmeEmail;
            tls_cert_file = listenerCfg.tlsCertFile;
          }
          else {
            tls_cert_file = listenerCfg.tlsCertFile;
            tls_key_file = listenerCfg.tlsKeyFile;
          }
        )
      )
    ]
    ++ acc) []
  (builtins.attrNames cfg.listeners);

  settings =
    {
      inherit listener;
      inherit (cfg) ui;
      # cluster_addr = cfg.clusterAddr;
      # api_addr = cfg.apiAddr;
    }
    // (
      if cfg.storage.type == "postgresql"
      then {
        storage = {
          postgresql = {
            inherit
              (cfg.storage.postgresql)
              table
              max_idle_connections
              max_parallel
              ha_enabled
              ha_table
              skip_create_table
              max_connect_retries
              ;
          };
        };
      }
      else {
        storage = {
          raft = {
            inherit
              (cfg.storage.raft)
              node_id
              path
              ;
          };
        };
      }
    )
    // cfg.extraSettings;
in {
  options = {
    os = {
      flavors = {
        ${name} = {
          enable = lib.mkEnableOption "Install ${name} NixOS flavors.";
          package = lib.mkPackageOption pkgs "openbao" {
            example = "pkgs.openbao.override { withHsm = false; withUi = false; }";
          };

          ui = lib.mkDefaultEnabledOption "Disable the OpenBao UI";

          clusterAddr = lib.mkOption {
            type = lib.types.nullOr lib.types.str;
            description = ''
              Specifies the address to advertise to other OpenBao servers in the
              cluster for request forwarding. Full URL of the form
              http://IP:PORT.
              Required if storage is set to "raft"
            '';
            default = null;
          };

          apiAddr = lib.mkOption {
            type = lib.types.nullOr lib.types.str;
            description = ''
              Specifies the address (full URL) to advertise to other OpenBao
              servers in the cluster for client redirection. Full URL of the form
              http://IP:PORT.
            '';
            default = null;
          };

          listeners = lib.mkOption {
            type = lib.types.attrsOf (lib.types.submodule (import ./listener.nix));
            description = "Listeners configuration.";
            default = {};
          };

          storage = lib.mkOption {
            type = lib.types.submodule (import ./storage.nix);
            description = "Backend storage configuration.";
            default = {};
          };

          extraSettings = lib.mkOption {
            type = lib.types.attrs;
            description = ''
              Extra openbao settings to add in addition to the default.
            '';
            default = {};
          };

          extraArgs = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = [];
            description = ''
              Additional arguments given to OpenBao.
            '';
          };
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    environment = {
      systemPackages = [
        cfg.package
      ];
    };

    users = {
      users = {
        openbao = {
          # home = "/var/lib/openbao";
          group = "openbao";
          isSystemUser = true;
        };
      };
    };

    users = {
      groups = {
        openbao = {};
      };
    };

    systemd = {
      services = {
        openbao = {
          description = "OpenBao - A tool for managing secrets";

          wantedBy = ["multi-user.target"];
          after = ["network.target"];

          restartIfChanged = false; # do not restart on "nixos-rebuild switch". It would seal the storage and disrupt the clients.
          environment = pgEnvVar;

          serviceConfig = {
            Type = "notify";

            ExecStart = lib.escapeShellArgs (
              [
                (lib.getExe cfg.package)
                "server"
                "-config"
                (settingsFormat.generate "openbao.hcl.json" settings)
              ]
              ++ cfg.extraArgs
            );
            ExecReload = "${lib.getExe' pkgs.coreutils "kill"} -SIGHUP $MAINPID";

            User = "openbao";
            Group = "openbao";
            DynamicUser = true;

            StateDirectory = "openbao";
            StateDirectoryMode = "0700";
            RuntimeDirectory = "openbao";
            RuntimeDirectoryMode = "0700";

            CapabilityBoundingSet = "";
            LimitCORE = 0;
            LockPersonality = true;
            MemorySwapMax = 0;
            MemoryZSwapMax = 0;
            PrivateUsers = true;
            ProcSubset = "pid";
            ProtectClock = true;
            ProtectControlGroups = true;
            ProtectHome = true;
            ProtectHostname = true;
            ProtectKernelLogs = true;
            ProtectKernelModules = true;
            ProtectKernelTunables = true;
            ProtectProc = "invisible";
            Restart = "on-failure";
            RestrictAddressFamilies = [
              "AF_INET"
              "AF_INET6"
              "AF_UNIX"
            ];
            RestrictNamespaces = true;
            RestrictRealtime = true;
            SystemCallArchitectures = "native";
            SystemCallFilter = [
              "@system-service"
              "@resources"
              "~@privileged"
            ];
            UMask = "0077";
          };
        };
      };
    };
  };
}
