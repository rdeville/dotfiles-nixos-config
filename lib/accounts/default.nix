let
  # HOME-MANAGER ACCOUNTS RELATED FUNCTIONS
  # ============================================================================
  mkDebug = data: builtins.trace (builtins.toJSON data);
  mkSlugEmail = email: builtins.replaceStrings ["@" "."] ["_at_" "_"] email;
  mkImap = domain: conn_type:
    if conn_type == "SSL/TLS"
    then {
      port = 993;
      tls = {enable = true;};
      host = domain;
    }
    else {
      port = 143;
      tls = {useStartTls = true;};
      host = domain;
    };

  mkSmtp = domain: conn_type: {
    port =
      if conn_type == "SSL/TLS"
      then 465
      else 587;
    tls =
      if conn_type == "SSL/TLS"
      then {enable = true;}
      else {useStartTls = true;};
    host = domain;
  };

  mkImportDir = dir:
    if builtins.pathExists dir
    then
      builtins.map (
        file: "${dir}/${file}"
      ) (builtins.attrNames (builtins.readDir dir))
    else [];

  mkEmailCfg = cfg: userAccount:
    if builtins.hasAttr "email" userAccount
    then
      userAccount.email
      // (
        import ./emails.nix {
          inherit
            cfg
            userAccount
            ;
        }
      )
    else {};

  mkCalendarCfg = cfg: userAccount:
    if builtins.hasAttr "calendar" userAccount
    then
      import ./calendars.nix {
        inherit
          cfg
          userAccount
          ;
      }
    else {};

  mkContactCfg = cfg: userAccount:
    if builtins.hasAttr "contact" userAccount
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
      mkDebug
      mkSlugEmail
      mkImap
      mkSmtp
      mkImportDir
      mkEmailCfg
      mkCalendarCfg
      mkContactCfg
      ;
  };
in
  lib
