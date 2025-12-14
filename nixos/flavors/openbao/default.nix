{
  config,
  lib,
  ...
}: let
  name = builtins.baseNameOf ./.;
  cfg = config.os.flavors.${name};
in {
  options = {
    os = {
      flavors = {
        ${name} = {
          enable = lib.mkEnableOption "Install ${name} NixOS flavors.";

          extraSettings = lib.mkOption {
            type = lib.types.attrs;
            description = ''
              Extra openbao settings to add in addition to the default.
            '';
            default = {};
          };

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
            type = lib.types.listOf (lib.types.submodule (import ./listener.nix));
            description = "Listeners configuration.";
            default = {};
          };

          storage = lib.mkOption {
            type = lib.types.submodule (import ./storage.nix);
            description = "Backend storage configuration.";
            default = {};
          };
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.storage.type == "raft" && cfg.clusterAddr != null;
        message = ''
          If `os.flavors.openbao.storage.type` is 'raft', then
          `os.flavors.openbao.clusterAdd` is required.
        '';
      }
      {
        assertion = cfg.storage.type == "raft" && cfg.storage.raft.node_id != null && cfg.storage.raft.path != null;
        message = ''
          If `os.flavors.openbao.storage.type` is 'raft', then
          `os.flavors.openbao.storage.raft.node_id` and `os.flavors.openbao.storage.raft.path` are required.
        '';
      }
    ];

    os = {
      services = {
        openbao = {
          enable = true;
          settings =
            {
              ui = true;
              api_addr = cfg.apiAddr;

              listener = builtins.foldl' (acc: elem:
                (
                  if elem.enable
                  then [
                    (
                      {
                        inherit (elem) type;
                        address =
                          if elem.interface != null
                          then let
                            address = builtins.elemAt config.os.flavors.network.networks.${elem.interface}.address 0;
                            ip = builtins.elemAt (lib.strings.splitString "/" address) 0;
                          in "${ip}:${toString elem.port}"
                          else "${elem.ip}:${toString elem.port}";
                        disable_unauthed_rekey_endpoints = elem.disableUnauthedRekeyEndpoints;
                        custom_response_headers = let
                          res =
                            elem.customResponseHeaders;
                        in {
                          default = res.default // res.extraDefault;
                        };
                      }
                      // (
                        if elem.tlsDisable
                        then {
                          tls_disable = elem.tlsDisable;
                        }
                        else if elem.tlsCertFile == ""
                        then {
                          tls_acme_ca_directory = elem.tlsAcmeCaDirectory;
                          tls_acme_domains = elem.tlsAcmeDomains;
                          tls_acme_email = elem.tlsAcmeEmail;
                          tls_cert_file = elem.tlsCertFile;
                        }
                        else {
                          tls_cert_file = elem.tlsCertFile;
                          tls_key_file = elem.tlsKeyFile;
                        }
                      )
                    )
                  ]
                  else []
                )
                ++ acc) []
              cfg.listeners;

              storage = let
                inherit (cfg.storage) type;
                backend = cfg.storage.${type};
              in {
                "${type}" = backend;
              };
            }
            // (
              if cfg.clusterAddr != null
              then {
                cluster_addr = cfg.clusterAddr;
              }
              else {}
            )
            // cfg.extraSettings;
        };
      };
    };
  };
}
