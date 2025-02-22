{config, ...}: {
  config = {
    programs = {
      zsh = {
        history = {
          append = true;
          expireDuplicatesFirst = true;
          findNoDups = true;
          ignoreAllDups = true;
          ignorePatterns = [
            "rm *"
            "pkill *"
          ];
          path = "${config.xdg.cacheHome}/zsh/zsh_history";
          saveNoDups = true;
          save = 50000;
          size = 50000;
        };
      };
    };
  };
}
