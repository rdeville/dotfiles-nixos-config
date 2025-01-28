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
        type = "discover";
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
        enable = false;
      };
      vdirsyncer = {
        enable = false;
      };
      primary = false;
    };
    contact = {
      khard = {
        enable = false;
      };
      vdirsyncer = {
        enable = false;
      };
    };
  };
in {
  inherit
    tuiSoft
    guiSoft
    ;
}
