local awful = require("awful")
local beautiful = require("widgets.theme")
local wibox = require("wibox")

local cpu = {}
local old_cpu = { 50, 50 }

local function factory(_)
  local function get_cpu_value()
    local data = split(os.capture("head -1 /proc/stat"), " ")
    local loadavg = split(os.capture("head -1 /proc/loadavg"), " ")
    local total = 0
    local active = 0

    active = sum_array(data, 2, 4) + sum_array(data, 7, 11) - old_cpu[1]
    total = sum_array(data, 5, 6) - old_cpu[2]
    old_cpu[1] = active
    old_cpu[2] = total

    return math.floor((active / total) * 1000) / 10, loadavg
  end

  local options = {
    timeout = beautiful.cpu_timeout or 1,
    clr_0 = beautiful.cpu_clr_3 or beautiful.clr_0 or beautiful.default_clr_0,
    clr_1 = beautiful.cpu_clr_2 or beautiful.clr_1 or beautiful.default_clr_1,
    clr_2 = beautiful.cpu_clr_1 or beautiful.clr_2 or beautiful.default_clr_2,
    clr_3 = beautiful.cpu_clr_0 or beautiful.clr_3 or beautiful.default_clr_3,
  }

  local update_widget = function(widget)
    local value, loadavg = get_cpu_value()

    widget.fg = options["clr_" .. math.floor(value / 25)]
    widget:get_children_by_id("cpu_value")[1].text =
      string.format(" %04.1f%%", value)
    widget:get_children_by_id("cpu_load")[1].text =
      string.format(" %03.2f", loadavg[1])
    widget:get_children_by_id("cpu_bar")[1].value = value
    widget:get_children_by_id("cpu_bar")[1].color = widget.fg
  end

  cpu = wibox.widget({
    {
      {
        {
          id = "cpu_icon",
          text = beautiful.cpu_icon or " ",
          widget = wibox.widget.textbox,
        },
        {
          {
            id = "cpu_bar",
            background_color = beautiful.cpu_bar_bg
              or beautiful.widget_default_bar_bg,
            shape = beautiful.cpu_bar_shape,
            max_value = 100,
            widget = wibox.widget.progressbar,
          },
          forced_width = beautiful.cpu_bar_width
            or beautiful.widget_bar_width
            or beautiful.widget_default_bar_width,
          direction = "east",
          layout = wibox.container.rotate,
        },
        {
          id = "cpu_value",
          widget = wibox.widget.textbox,
        },
        {
          id = "cpu_load",
          widget = wibox.widget.textbox,
        },
        layout = wibox.layout.fixed.horizontal,
      },
      widget = wibox.container.margin(nil, 15, 15, 0, 0),
    },
    bg = beautiful.cpu_bg or beautiful.widget_default_bg,
    font = beautiful.cpu_font or beautiful.font,
    shape = beautiful.cpu_shape or beautiful.widget_default_shape_right,
    widget = wibox.container.background,
  })

  awful.widget.watch("echo &>/dev/null", options.timeout, update_widget, cpu)

  return cpu
end

return setmetatable(cpu, {
  __call = function(_, ...)
    return factory(...)
  end,
})
