local beautiful = require("widgets.theme")
local dpi = require("beautiful.xresources").apply_dpi
local gears = require("gears")
local wibox = require("wibox")

local user = wibox.widget({
  {
    {
      {
        image = beautiful.cc_user_icon
          or script_path() .. "../icons/default_user.svg",
        resize = true,
        forced_width = dpi(38),
        forced_height = dpi(38),
        widget = wibox.widget.imagebox,
      },
      {
        markup = "<span size='x-large'>"
          .. (beautiful.cc_user_name or os.capture("whoami"))
          .. "</span>",
        font = beautiful.cc_user_font or beautiful.cc_font or beautiful.font,
        valign = "center",
        align = "center",
        widget = wibox.widget.textbox,
      },
      layout = wibox.layout.flex.horizontal,
    },
    widget = wibox.container.margin(nil, 15, 15, 5, 5),
  },
  bg = beautiful.cc_user_bg
    or beautiful.cc_button_inactive_bg
    or beautiful.cc_button_inactive_default_bg,
  fg = beautiful.cc_user_fg
    or beautiful.cc_button_inactive_fg
    or beautiful.cc_button_inactive_default_fg,
  shape = gears.shape.rounded_rect,
  widget = wibox.container.background,
})

return user
