local awful = require("awful")
local beautiful = require("widgets.theme")
local clickable_container =
  require("widgets.control_center.clickable-container")
local dpi = beautiful.xresources.apply_dpi
local wibox = require("wibox")
local gears = require("gears")

local slider_wrapped = wibox.widget({
  {
    {
      {
        {
          id = "icon",
          image = beautiful.cc_slider_brightness_icon_path
            or script_path() .. "../icons/brightness.svg",
          resize = true,
          forced_height = dpi(16),
          forced_width = dpi(16),
          widget = wibox.widget.imagebox,
        },
        margins = dpi(4),
        widget = wibox.container.margin,
      },
      bg = beautiful.cc_slider_brightness_inactive
        or beautiful.cc_slider_inactive_bg
        or beautiful.cc_slider_inactive_default_bg,
      shape = gears.shape.circle,
      widget = wibox.container.background,
    },
    right = dpi(25),
    widget = wibox.container.margin,
  },
  {
    {
      id = "slider",
      bar_shape = gears.shape.rounded_rect,
      bar_height = dpi(3),
      bar_color = beautiful.cc_slider_brightness_bar_inactive_bg
        or beautiful.cc_slider_inactive_bg
        or beautiful.cc_slider_inactive_default_bg,
      bar_active_color = beautiful.cc_slider_brightness_bar_active_bg
        or beautiful.cc_slider_active_bg
        or beautiful.cc_slider_active_default_bg,

      handle_shape = gears.shape.circle,
      handle_width = dpi(12),
      handle_color = beautiful.cc_slider_brightness_bar_active_bg
        or beautiful.cc_slider_active_bg
        or beautiful.cc_slider_active_default_bg,

      value = 100,
      minimum = 0,
      maximum = 100,
      forced_height = dpi(20),
      widget = wibox.widget.slider,
    },
    widget = clickable_container,
  },
  {
    {
      id = "value",
      widget = wibox.widget.textbox,
    },
    left = dpi(25),
    widget = wibox.container.margin,
  },
  spacing = dpi(15),
  layout = wibox.layout.align.horizontal,
})

local function update_brightness()
  awful.spawn.easy_async_with_shell("xbacklight -get", function(stdout)
    slider_wrapped:get_children_by_id("slider")[1].value = stdout
    slider_wrapped:get_children_by_id("value")[1].text = math.floor(stdout)
      .. "%"
  end)
end

-- When sliding happens
slider_wrapped
  :get_children_by_id("slider")[1]
  :connect_signal("property::value", function(_, value)
    awful.spawn.with_shell("xbacklight -set " .. value)
    slider_wrapped:get_children_by_id("value")[1].text = math.floor(value)
      .. "%"
  end)

update_brightness()

return slider_wrapped
