local beautiful = require("widgets.theme")
local wibox = require("wibox")

local date = {}

local function factory(_)
  date = wibox.widget({
    {
      {
        format = beautiful.date_format or "  %a %d %b | %H:%M",
        widget = wibox.widget.textclock,
      },
      widget = wibox.container.margin(nil, 15, 15, 0, 0),
    },
    fg = beautiful.date_fg or beautiful.widget_default_fg,
    bg = beautiful.date_bg or beautiful.widget_default_bg,
    font = beautiful.date_font or beautiful.font,
    shape = beautiful.date_shape or beautiful.widget_default_shape_right,
    widget = wibox.container.background,
  })

  return date
end

return setmetatable(date, {
  __call = function(_, ...)
    return factory(...)
  end,
})
