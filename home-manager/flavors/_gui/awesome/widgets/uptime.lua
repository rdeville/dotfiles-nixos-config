local awful = require("awful")
local beautiful = require("widgets.theme")
local wibox = require("wibox")

local uptime = {}

local function factory(_)
  local options = {
    timeout = beautiful.uptime_timeout or 30,
    command = beautiful.uptime_command or "cat /proc/uptime",
  }

  local update_widget = function(widget, stdout, _, _, _)
    local time = math.floor(string.match(stdout, "[%d]+"))
    local days = math.floor(time / (3600 * 24))
    local hours = math.floor((time % (3600 * 24)) / 3600)
    local minutes = math.floor(((time % (3600 * 24)) % 3600) / 60)
    local color = gradient(0, 24, hours)
    local text = beautiful.uptime_icon or "󰔚 "
    if days > 0 then
      text = text .. string.format(" %02d Days", days)
    else
      text = text .. string.format(" %02d:%02d", hours, minutes)
    end
    widget.fg = color
    widget:get_children_by_id("text")[1].text = text
  end

  uptime = wibox.widget({
    {
      {
        id = "text",
        widget = wibox.widget.textbox,
      },
      widget = wibox.container.margin(nil, 15, 15, 0, 0),
    },
    bg = beautiful.uptime_bg or beautiful.widget_default_bg,
    shape = beautiful.uptime_shape or beautiful.widget_default_shape_right,
    widget = wibox.container.background,
  })

  awful.widget.watch(options.command, options.timeout, update_widget, uptime)

  return uptime
end

return setmetatable(uptime, {
  __call = function(_, ...)
    return factory(...)
  end,
})
