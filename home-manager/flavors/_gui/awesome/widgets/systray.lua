local beautiful = require("widgets.theme")
local colors = require("utils.colors")
local wibox = require("wibox")

local systray = {}

beautiful.bg_systray = beautiful.bg_systray
  or beautiful.systray_bg
  or colors.brown_500

local function factory(_)
  systray = wibox.widget({
    {
      wibox.widget.systray(),
      widget = wibox.container.margin(nil, 15, 15, 0, 0),
    },
    bg = beautiful.bg_systray,
    shape = beautiful.cpu_shape or beautiful.widget_default_shape_left,
    widget = wibox.container.background,
  })
  return systray
end

return setmetatable(systray, {
  __call = function(_, ...)
    return factory(...)
  end,
})
