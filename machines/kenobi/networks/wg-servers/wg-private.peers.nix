[
  # KENOBI
  {
    # vm-kenobi-k8s-prd
    AllowedIPs = "172.18.128.201/32";
    PublicKey = ../../microvms/k8s-prd/_keys/wg-private.pub;
  }
  {
    # vm-kenobi-k8s-prd
    AllowedIPs = "172.18.144.201/32";
    PublicKey = ../../microvms/k8s-stg/_keys/wg-private.pub;
  }
  {
    # vm-kenobi-k8s-prd
    AllowedIPs = "172.18.160.201/32";
    PublicKey = ../../microvms/k8s-dev/_keys/wg-private.pub;
  }
  # DARTH MAUL
  {
    # darth-maul
    AllowedIPs = "172.18.0.2/32";
    PublicKey = ../../../darth-maul/_keys/wg-private.pub;
  }
  {
    # vm-darth-maul-k8s-dev
    AllowedIPs = "172.18.160.202/32";
    PublicKey = ../../../darth-maul/microvms/k8s-dev/_keys/wg-private.pub;
  }
  # REY
  {
    # rey
    AllowedIPs = "172.18.0.3/32";
    PublicKey = ../../../rey/_keys/wg-private.pub;
  }
  {
    # vm-rey-k8s-dev
    AllowedIPs = "172.18.160.203/32";
    PublicKey = ../../../rey/microvms/k8s-dev/_keys/wg-private.pub;
  }
  # LUKE
  {
    AllowedIPs = "172.18.144.11/32";
    PublicKey = ../../../luke/_keys/wg-private.pub;
  }
  # LEIA
  {
    AllowedIPs = "172.18.144.21/32";
    PublicKey = ../../../leia/_keys/wg-private.pub;
  }
  # LILITH
  {
    AllowedIPs = "172.18.128.31/32";
    PublicKey = ../../../lilith/_keys/wg-private.pub;
  }
  # MAYA
  {
    AllowedIPs = "172.18.128.32/32";
    PublicKey = ../../../maya/_keys/wg-private.pub;
  }
  # AVA
  {
    AllowedIPs = "172.18.128.33/32";
    PublicKey = ../../../ava/_keys/wg-private.pub;
  }
]
