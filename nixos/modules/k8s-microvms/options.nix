{
  config,
  lib,
  name,
  ...
}: {
  options = {
    enable = lib.mkEnableOption "Enable VM";
    network = {
      debug = lib.mkEnableOption "Enable network debug";
      enableFirewall = lib.mkDefaultEnabledOption "Disable firewall";
      enableNftable = lib.mkDefaultEnabledOption "Disable nftable";
    };

    name = lib.mkOption {
      type = lib.types.str;
      description = "This network interface.";
      default = name;
      readOnly = true;
    };

    vcpu = lib.mkOption {
      type = lib.types.int;
      description = "Number of virtual CPU for the VM";
      default = 1;
    };

    mem = lib.mkOption {
      type = lib.types.int;
      description = "Memory (in MB) for the VM";
      # Qemu hang if exactly 2GB
      default = 2050;
    };

    role = lib.mkOption {
      type = lib.types.enum [
        "server"
        "agent"
      ];
      description = "Role of the machine in the cluster";
    };

    id = lib.mkOption {
      type = lib.types.int;
      description = ''
        ID of the VMs, will be used for the IP, that will be of the
        form : 172.NET.envID.id.
      '';
    };

    env = lib.mkOption {
      type = lib.types.str;
      description = "Environment in which belong the VM";
    };

    envID = lib.mkOption {
      type = lib.types.str;
      description = ''
        ID of the environment, will be use for the IP, that will be of
        the form : 172.NET.envID.id
      '';
      readOnly = true;
      default =
        if config.env == "dev"
        then "160"
        else if config.env == "stg"
        then "144"
        else if config.env == "prd"
        then "128"
        else "";
    };

    defaultSopsFile = lib.mkOption {
      type = lib.types.path;
      description = ''
        Path to the default Sops secret file containing user passwords.
      '';
    };

    hostKeyDir = lib.mkOption {
      type = lib.types.path;
      description = ''
        Path to the directory containing host keys.
      '';
    };

    clusterInit = lib.mkEnableOption "Cluster initialization";
    disableAgent = lib.mkEnableOption "Disable agent";

    clusterDomain = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = ''
        List of domain name to add to the option --tls-san when the option
        clusterInit is set to true.
      '';
      default = [];
    };

    clusterAddress = lib.mkOption {
      type = lib.types.str;
      description = ''
        Address of the kubernetes control planes.
      '';
      default = "";
    };

    wireguard = {
      endpoint = lib.mkOption {
        type = lib.types.str;
        description = ''
          IP Address of the wireguard endpoint to connect.
        '';
        default = "172.20.${config.envID}.1";
      };
    };
  };
}
