{pkgs, ...}: {
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
