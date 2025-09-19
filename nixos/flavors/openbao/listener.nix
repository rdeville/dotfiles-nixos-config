{
  config,
  lib,
  name,
  ...
}: let
  cfg = config;
in {
  options = {
    enable = lib.mkDefaultEnabledOption "Enable interface";

    name = lib.mkOption {
      type = lib.types.str;
      description = "This network interface.";
      default = name;
      readOnly = true;
    };

    type = lib.mkOption {
      type = lib.types.enum ["tcp" "unix"];
      description = ''
        Type of listener.
      '';
      default = "tcp";
    };

    ip = lib.mkOption {
      type = lib.types.str;
      description = ''
        IP address the listener should listen to.
        Value will be ignored if `os.flavors.openbao.listener.<name>.interface`
        is defined.
      '';
      default = "127.0.0.1";
    };

    interface = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      description = ''
        Name of the interface to use for the listener.
        IP of the interface will be extracted to build the listener.
        If defined, will make `os.flavors.openbao.listener.<name>.ip` ignored.
      '';
      default = null;
    };

    port = lib.mkOption {
      type = lib.types.int;
      description = ''
        Port the listener should listen to.
      '';
      default = 8200;
    };

    disableUnauthedRekeyEndpoints = lib.mkDefaultEnabledOption ''
      Whether to disable requests to the legacy unauthenticated rekey endpoints
      (under /sys/rekey/* and /sys/rekey-recovery-key/*)
    '';

    tlsDisable = lib.mkEnableOption ''
      Specifies if TLS will be disabled. Default set to `false`, so you must
      explicitly disable TLS to opt-in to insecure communication.
    '';

    tlsCertFile = lib.mkOption {
      type = lib.types.str;
      description = ''
        Specifies the path to the certificate for TLS.
      '';
      default = "";
    };

    tlsKeyFile = lib.mkOption {
      type = lib.types.str;
      description = ''
        Specifies the path to the private key for the certificate.
      '';
    };

    tlsAcmeCaDirectory = lib.mkOption {
      type = lib.types.str;
      description = ''
        Path to the ACME directory; defaults to Let's Encrypt's production CA.
      '';
      default = "https://acme-v02.api.letsencrypt.org/directory";
    };

    tlsAcmeEmail = lib.mkOption {
      type = lib.types.str;
      description = ''
        Specify an optional account the CA may contact you at for expiring
        certificates or other service-related emails.
      '';
    };

    tlsAcmeDomains = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = ''
        An optional but strongly recommended allow-list of domains to allow
        acquiring certificates for.
      '';
    };

    customResponseHeaders = {
      default = lib.mkOption {
        type = lib.types.attrs;
        description = ''
          A map of string header names to an array of string values. The default
          headers are set on all endpoints regardless of the status code value.
        '';
        default = {
          Strict-Transport-Security = ["max-age=31536000" "includeSubDomains"];
        };
        readOnly = true;
      };

      extraDefault = lib.mkOption {
        type = lib.types.attrs;
        description = ''
          A map of string header names to an array of string values. The default
          headers are set on all endpoints regardless of the status code value.
        '';
        default = {};
      };
    };

    extraCollectiveStatusCode = lib.mkOption {
      type = lib.types.attrs;
      description = ''
        A map of string header names to an array of string values. These headers
        are set only when the response status code falls under the collective
        status code. For example, "2xx" = {"Header-A": ["Value1", "Value2"]},
        "Header-A" is set when the http response status code is "200", "204",
        etc.
      '';
      default = {};
      readOnly = true;
    };
  };
}
