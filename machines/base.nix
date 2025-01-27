{
  users = {
    openssh = {
      authorizedKeys = {
        keyFiles = [
          ./darth-maul/rdeville/keys/rdeville-darth-maul.pub
          ./rey/rdeville/keys/rdeville-rey.pub
          ./darth-plagueis/rdeville/keys/rdeville-darth-plagueis.pub
        ];
      };
    };
  };
  sops = {
    keyFile = "/etc/ssh/.age.key";
  };
}
