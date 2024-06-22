{
  config,
  lib,
  pkgs,
  cfg,
  ...
}: let
  neomuttAccounts = builtins.filter (account: account.neomutt.enable) (
    builtins.attrValues config.accounts.email.accounts
  );
in {
  # Let Home Manager install and manage itself.
  programs = {
    neomutt = {
      enable = neomuttAccounts != [];
      checkStatsInterval = 300;
      # unmailboxes
      # extraConfig = "";
      # settings
      sidebar = {
        enable = true;
        format = "%D %B %* [%?N?%N / ?%S]";
        shortPath = true;
        width = 25;
      };
      # binds = {
      #   <*> = {
      #     action;
      #     key;
      #     map;
      #   };
      # };
      # macros = {
      #   <*> = {
      #     action;
      #     key;
      #     map;
      #   };
      # };
    };
  };
}
