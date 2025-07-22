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
  # Darth Maul
  {
    # darth-maul
    AllowedIPs = "172.18.0.2/32";
    PublicKey = ../../../darth-maul/_keys/wg-private.pub;
  }
  {
    # vm-darth-maul-k8s-dev
    AllowedIPs = "172.18.0.202/32";
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
    AllowedIPs = "172.18.0.203/32";
    PublicKey = ../../../rey/microvms/k8s-dev/_keys/wg-private.pub;
  }
  # LUKE
  # LEIA
  # LILITH
  # MAYA
  # AVA
]
