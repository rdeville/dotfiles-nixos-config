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
        enable = false;
        type = "discover";
      };
      thunderbird = {
        enable = false;
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
      thunderbird = {
        enable = false;
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
      thunderbird = {
        # Does not seems do discover calendars properly
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
      thunderbird = {
        enable = true;
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
