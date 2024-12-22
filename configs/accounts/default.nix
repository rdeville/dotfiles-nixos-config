let
  tuiSoft = primary: {
    email = {
      thunderbird = {
        enable = false;
      };
      inherit primary;
    };
    calendar = {
      khal = {
        enable = true;
      };
      vdirsyncer = {
        enable = true;
      };
      inherit primary;
    };
    contact = {
      khard = {
        enable = true;
      };
      vdirsyncer = {
        enable = true;
      };
    };
  };

  guiSoft = {
    email = {
      thunderbird = {
        enable = true;
      };
      primary = false;
    };
    calendar = {
      khal = {
        enable = true;
      };
      vdirsyncer = {
        enable = true;
      };
      primary = false;
    };
    contact = {
      khard = {
        enable = true;
      };
      vdirsyncer = {
        enable = true;
      };
    };
  };
in {
  inherit
    tuiSoft
    guiSoft
    ;
}
