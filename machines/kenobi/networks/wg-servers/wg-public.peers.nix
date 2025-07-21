[
  # Kenobi
  # IP 172.17.0.1/32 is reserved for Kenobi, the router
  #
  # Darth-Maul
  # IP 172.17.0.2/32 is reserved for Darth-Maul, already in local net of Kenobi
  #
  # Rey
  {
    AllowedIPs = "172.17.0.3/32";
    PublicKey = ../../../rey/_keys/wg-public.pub;
  }
  # P-Wing
  {
    AllowedIPs = "172.17.0.4/32";
    PublicKey = "NI2ltuOY3kuvhlIWH9XPyt32bRZ9pMxGLTlnUz1gjXQ=";
  }
]
