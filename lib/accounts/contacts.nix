{
  cfg,
  userAccount,
  ...
}: let
  # abookConvert = nixpkgs.lib.optionals home-manager.programs.abook.enable [
  #   "abook"
  #   "--config ${home-manager.xdg.configFile."abook/abookrc".source}"
  #   "--convert"
  #   "--informat vcard"
  #   "--infile /tmp/contact.vcf"
  #   "--outformat   abook"
  #   "--outfile ~/.local/share/abook/addressbook"
  # ];
  # catVcard = [
  #   "cat"
  #   config.accounts.contact.accounts.basePath
  # ];
in {
  # name = builtins.replaceStrings ["@" "."] ["_at_" "_"] userAccount.email.address;
  local = {
    type = "filesystem";
    fileExt = ".vcf";
  };
  remote = {
    passwordCommand = userAccount.calendar.passwordCommand;
    type = "carddav";
    url = userAccount.calendar.url;
    userName = userAccount.calendar.userName;
  };
  # Currently disabling khard as config generated with account is incompatible
  # with recursive vcard discovery
  # See : https://github.com/nix-community/home-manager/pull/5220
  khard = {
    enable = false;
  };
  vdirsyncer = {
    enable = true;
    collections = ["from a" "from b"];
    conflictResolution = ["b wins"];
    # postHook = if config.programs.abook.enable
    #   then  builtins.concatStringsSep " " [
    #     "abook"
    #     "--config"
    #     "${xdg.configFile."abook/abookrc".source}"
    #     "--convert"
    #     "--informat"
    #     "vcard"
    #     ;
    #   else "";
  };
}
