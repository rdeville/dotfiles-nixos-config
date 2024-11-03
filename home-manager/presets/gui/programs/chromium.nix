{
  userCfg,
  lib,
  ...
}:
lib.mkIf (! userCfg.isDarwin) {
  programs = {
    chromium = {
      enable = true;
      dictionaries = [];
      extensions = [
        {id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";} # Dark Reader
        {id = "clngdbkpkpeebahjckkjfobafhncgmne";} # Stylus
        {id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";} # uBlock Origin
        {id = "hfjbmagddngcpeloejdejnfgbamkjaeg";} # Vimium C
        {id = "doojmbjmlfjjnbmnoijecmcbfeoakpjm";} # NoScript
      ];
    };
  };
}
