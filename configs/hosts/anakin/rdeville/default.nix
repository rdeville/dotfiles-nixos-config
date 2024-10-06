{presets, ...}: {
  sops = {
    age = {
      keyFile = "/home/rdeville/.cache/.age.key";
    };
    # defaultSopsFile = ./rdeville.enc.yaml;
    secrets = {};
  };

  presets = presets;

  flavors = {
    bin = {
      enable = true;
    };
  };
}
