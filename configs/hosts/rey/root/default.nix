{presets, ...}: {
  # sops = {
  #   age = {
  #     keyFile = "/root/.cache/.age.key";
  #   };
  #   # defaultSopsFile = ./rdeville.enc.yaml;
  #   secrets = {};
  # };

  presets = presets;

  flavors = {
    bin = {
      enable = true;
    };
  };
}
