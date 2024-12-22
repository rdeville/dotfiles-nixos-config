lib: let
  default = import ../configs/accounts;

  mkImap = domain: conn_type: {
    port =
      if conn_type == "SSL/TLS"
      then 993
      else 143;
    tls =
      if conn_type == "SSL/TLS"
      then {
        enable = true;
      }
      else {
        useStartTls = true;
      };
    host = domain;
  };

  mkSmtp = domain: conn_type: {
    port =
      if conn_type == "SSL/TLS"
      then 465
      else 587;
    tls =
      if conn_type == "SSL/TLS"
      then {
        enable = true;
      }
      else {
        useStartTls = true;
      };
    host = domain;
  };

  mkImportCfg = type: typeCfg: hm:
    import ./${type}.nix {
      inherit lib hm;
      ${type} = typeCfg;
    };
in {
  inherit
    mkImap
    mkSmtp
    mkImportCfg
    ;
}
