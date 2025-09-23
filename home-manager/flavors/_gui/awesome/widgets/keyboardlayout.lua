local awful = require("awful")
local beautiful = require("widgets.theme")
local wibox = require("wibox")

local keyboardlayout = {}

local function factory(_)
  keyboardlayout = wibox.widget({
    {
      {
        {
          id = "icon",
          text = beautiful.keyboardlayout_icon or " ",
          widget = wibox.widget.textbox,
        },
        awful.widget.keyboardlayout,
        layout = wibox.layout.align.horizontal,
      },
      widget = wibox.container.margin(nil, 15, 10, 0, 0),
    },
    fg = beautiful.keyboardlayout_fg or beautiful.widget_default_fg,
    bg = beautiful.keyboardlayout_bg or beautiful.widget_default_bg,
    font = beautiful.keyboardlayout_font or beautiful.font,
    shape = beautiful.keyboardlayout_shape or beautiful.widget_default_shape_right,
    widget = wibox.container.background,
  })

  return keyboardlayout
end

return setmetatable(keyboardlayout, {
  __call = function(_, ...)
    return factory(...)
  end,
})
