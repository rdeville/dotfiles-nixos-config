{
  users = {
    openssh = {
      authorizedKeys = {
        keyFiles = [
          ./darth-maul/rdeville/rdeville-darth-maul.pub
          ./rey/rdeville/rdeville-rey.pub
          ./darth-plagueis/rdeville/rdeville-darth-plagueis.pub
        ];
      };
    };
  };
  sops = {
    keyFile = "/etc/ssh/.age.key";
  };
}
