{
  config,
  lib,
  ...
}: {
  imports = [
    ./profiles.nix
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
