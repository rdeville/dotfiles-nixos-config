{hostname, ...}: let
  default = import ../default.nix;

  system = "x86_64-linux";
in {
  inherit system hostname;

  mkDefaultUserCfg = username: {
    inherit system hostname username;
    inherit (default) stateVersion;
  };
}
