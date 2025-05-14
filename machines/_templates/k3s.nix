{...}: {
  networking = {
    firewall = {
      allowPing = true;
    };
  };

  os = {
    flavors = {
      k3s = {
        enable = true;
        extraFlags = [
          "--default-local-storage-path /var/lib/k8s-data"
        ];
      };
    };
  };
}
