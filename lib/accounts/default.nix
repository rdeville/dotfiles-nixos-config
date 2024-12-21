lib: let
  mkImap = domain: conn_type:
    if conn_type == "SSL/TLS"
    then {
      port = 993;
      tls = {
        enable = true;
      };
      host = domain;
    }
    else {
      port = 143;
      tls = {
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

  mkEmailCfg = userCfg: accountCfg:
    if accountCfg ? email
    then
      accountCfg.email
      // (
        import ./emails.nix {
          inherit
            userCfg
            accountCfg
            ;
        }
      )
    else {};

  mkCalendarCfg = cfg: userAccount:
    if userAccount ? calendar
    then
      import ./calendars.nix {
        inherit
          cfg
          userAccount
          ;
      }
    else {};

  mkContactCfg = cfg: userAccount:
    if userAccount ? contact
    then
      import ./contacts.nix {
        inherit
          cfg
          userAccount
          ;
      }
    else {};

  lib = {
    inherit
      mkImap
      mkSmtp
      mkEmailCfg
      mkCalendarCfg
      mkContactCfg
      ;
  };
in
  lib
