{config, ...}: let
  khalCalendarAccounts = builtins.filter (account: account.khal.enable) (
    builtins.attrValues config.accounts.calendar.accounts
  );
in {
  programs = {
    khal = {
      enable = khalCalendarAccounts != [];
      settings = {
        default = {
          timedelta = "7d";
          default_event_alarm = "30m";
          default_event_duration = "30m";
          highlight_event_days = true;
          show_all_days = true;
        };
        locale = {
          firstweekday = 0;
          timeformat = "%H:%M";
          dateformat = "%d-%m-%Y";
          longdateformat = "%d %B %Y";
          datetimeformat = "%d-%m-%Y %H:%M";
          longdatetimeformat = "%Y-%m-%d %H:%M";
          weeknumbers = "left";
        };
        highlight_days = {
          method = "fg";
          multiple = "#0000FF";
          multiple_on_overflow = true;
        };
        keybindings = {
          export = "";
          external_edit = "e";
        };
        view = {
          agenda_event_format = "{calendar-color}{cancelled}{start-end-time-style} {title}{repeat-symbol}{alarm-symbol}{reset}";
          dynamic_days = false;
          event_format = "{calendar-color}{cancelled}{start}-{end} {title}{repeat-symbol}{alarm-symbol}{reset}";
          event_view_always_visible = true;
          frame = "color";
          min_calendar_display = 3;
          theme = "dark";
        };
        palette = {
          # key = foreground, background, mono, foreground_high, background_high
          header = "'white', 'dark green', default, '#DDDDDD', '#2E7D32'";
          "line header" = "'white', 'dark green', default, '#DDDDDD', '#2E7D32'";
          # alt header = 'white', '', 'bold'
          footer = "'white', 'black', bold, '#DDDDDD', '#43A047'";
          # bright = 'dark blue', 'white', 'bold,standout'
          # list = 'black', 'white'
          # list focused = 'white', 'light blue', 'bold'
          edit = "'white', 'black', default, '#DDDDDD', '#333333'";
          "edit focus" = "'white', 'light green', 'bold'";
          button = "'black', 'red'";
          # button focused = 'white', 'light blue', 'bold'

          # reveal focus = 'black', 'light gray'
          # today focus = 'white', 'dark magenta'
          # today = 'dark gray', 'dark green',

          # date header = 'light gray', 'black'
          # date header focused = 'black', 'white'
          # date header selected = 'dark gray', 'light gray'

          # dayname = 'light gray', ''
          # monthname = 'light gray', ''
          # weeknumber_right = 'light gray', ''
          # alert = 'white', 'dark red'
          # mark = 'white', 'dark green'
          # frame = 'white', 'black'
          # frame focus = 'light red', 'black'
          # frame focus color = 'dark blue', 'black'
          # frame focus top = 'dark magenta', 'black'

          # eventcolumn = '', '', ''
          # eventcolumn focus = '', '', ''
          # calendar = '', '', ''
          # calendar focus = '', '', ''

          # editbx = 'light gray', 'dark blue'
          # editcp = 'black', 'light gray', 'standout'
          # popupbg = 'white', 'black', 'bold'
          # popupper = 'white', 'dark cyan'
          # caption = 'white', '', 'bold'
        };
      };
    };
  };
}
