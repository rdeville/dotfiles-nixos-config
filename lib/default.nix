lib: let
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

  getValidHosts =
    builtins.filter (host: (
      builtins.pathExists ../machines/${host}/default.nix
    )) (
      builtins.filter (host: (
        # Ignore folders machines/_*
        builtins.match "_.*" host != []
      )) (lib.listDirs ../machines)
    );
in {
  inherit
    getValidHosts
    mkImap
    mkSmtp
    mkImportCfg
    ;
}
