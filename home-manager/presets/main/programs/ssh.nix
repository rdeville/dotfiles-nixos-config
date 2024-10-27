{...}: let
  darth-vader = {
    name = "darth-vader";
    hostname = "romaindeville.fr";
  };
  darth-plagueis = {
    name = "darth-plagueis";
    hostname = "romaindeville.ovh";
  };
  darth-maul = {
    name = "darth-maul";
    hostname = "romaindeville.fr";
  };

  mkConfig = server: user: {
    hostname = server.hostname;
    identitiesOnly = true;
    user = user;
    identityFile = "~/.ssh/pubkeys/${user}@${server.name}.pub";
  };
in {
  programs = {
    ssh = {
      matchBlocks = {
        "${darth-vader.name}" = mkConfig darth-vader "rdeville";
        "${darth-plagueis.name}" = mkConfig darth-plagueis "rdeville";
        "${darth-maul.name}" = mkConfig darth-maul "rdeville";
      };
    };
  };
}
