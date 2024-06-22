{
  pkgs,
  mkLib,
  ...
}: let
  framagit = "framagit.org";
  github = "github.com";
  gitlab = "gitlab.com";
  mkConfig = hostname: {
    hostname = hostname;
    identitiesOnly = true;
    identityFile = "~/.ssh/pubkeys/code+public_rsa@romaindeville.fr.pub";
  };
in {
  programs = {
    ssh = {
      enable = true;
      forwardAgent = true;
      hashKnownHosts = true;
      includes = ["~/.ssh/config.d/"];
      matchBlocks = {
        "${framagit}" = mkConfig framagit;
        "${github}" = mkConfig github;
        "${gitlab}" = mkConfig gitlab;
      };
    };
  };

  services = {
    ssh-agent = {
      enable = true;
    };
  };
}
