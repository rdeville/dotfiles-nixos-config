{
  config,
  lib,
  ...
}: {
  imports = [
    ./profiles.nix
    ./policies.extensions.nix
  ];

  config = lib.mkIf (! config.hm.isDarwin) {
    programs = {
      firefox = {
        enable = true;
        policies = import ./policies.nix;
      };
    };
  };
}
