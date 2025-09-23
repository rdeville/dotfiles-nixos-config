local awful = require("awful")
local beautiful = require("widgets.theme")
local wibox = require("wibox")

local ram = {}

local function factory(_)
  local function content(bytes)
    local format = " %04.2f %s"
    if bytes < 1024 then
      return string.format(format, bytes, "b")
    elseif bytes < 1024 ^ 2 then
      return string.format(format, bytes / 1024, "Kib")
    elseif bytes < 1024 ^ 3 then
      return string.format(format, bytes / 1024 ^ 2, "Mib")
    elseif bytes < 1024 ^ 4 then
      return string.format(format, bytes / 1024 ^ 3, "Gib")
    end
  end

  local function get_ram_value(stat_line)
    local raw_data = split(stat_line, " ")
    local active = tonumber(raw_data[3]) -- + tonumber(raw_data[5])
    local total = tonumber(raw_data[2])

    return {
      text = content(active),
      percent = math.floor((active / total) * 1000) / 10,
    }
  end

  local options = {
    timeout = beautiful.ram_timeout or 1,
    clr_0 = beautiful.net_clr_0 or beautiful.clr_0 or beautiful.default_clr_0,
    clr_1 = beautiful.net_clr_1 or beautiful.clr_1 or beautiful.default_clr_1,
    clr_2 = beautiful.net_clr_2 or beautiful.clr_2 or beautiful.default_clr_2,
    clr_3 = beautiful.net_clr_3 or beautiful.clr_3 or beautiful.default_clr_3,
  }

  local update_widget_used = function(widget)
    local data = get_ram_value(os.capture("free -b | grep 'Mem:'"))
    local color = math.floor(data.percent / 25) == 4 and 3
      or math.floor(data.percent / 25)

    -- Update widget values
    widget.fg = options["clr_" .. color]
    widget:get_children_by_id("ram_bar")[1].value = data.percent
    widget:get_children_by_id("ram_bar")[1].color = options["clr_" .. color]
    widget:get_children_by_id("ram_value")[1].text = data.text
  end

  ram = wibox.widget({
    {
      {
        {
          id = "ram_icon",
          text = beautiful.ram_icon or " ",
          widget = wibox.widget.textbox,
        },
        {
          {
            id = "ram_bar",
            background_color = beautiful.ram_bar_bg
              or beautiful.widget_default_bar_bg,
            shape = beautiful.ram_bar_shape,
            max_value = 100,
            widget = wibox.widget.progressbar,
          },
          forced_width = beautiful.ram_bar_width
            or beautiful.widget_bar_width
            or beautiful.widget_default_bar_width,
          direction = "east",
          layout = wibox.container.rotate,
        },
        {
          id = "ram_value",
          widget = wibox.widget.textbox,
        },
        layout = wibox.layout.align.horizontal,
      },
      widget = wibox.container.margin(nil, 15, 15, 0, 0),
    },
    bg = beautiful.ram_bg or beautiful.widget_default_bg,
    font = beautiful.ram_font or beautiful.font,
    shape = beautiful.ram_shape or beautiful.widget_default_shape_right,
    widget = wibox.container.background,
  })

  awful.widget.watch("echo &>/dev/null", options.timeout, update_widget_used, ram)

  return ram
end

return setmetatable(ram, {
  __call = function(_, ...)
    return factory(...)
  end,
})
