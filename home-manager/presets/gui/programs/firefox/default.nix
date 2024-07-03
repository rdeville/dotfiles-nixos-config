{
  userCfg,
  pkgs,
  ...
}: {
  programs = {
    firefox = {
      enable = true;
      # See list of policies https://mozilla.github.io/policy-templates/
      policies = import ./policies.nix;
      profiles = import ./profiles.nix userCfg pkgs;
    };
  };
}
