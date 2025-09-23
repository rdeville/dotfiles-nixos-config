local awful = require("awful")
local beautiful = require("widgets.theme")
local clickable_container =
  require("widgets.control_center.clickable-container")
local dpi = beautiful.xresources.apply_dpi
local gears = require("gears")
local wibox = require("wibox")

local slider_widget = wibox.widget({
  {
    {
      {
        {
          {
            id = "icon",
            resize = true,
            forced_height = dpi(16),
            forced_width = dpi(16),
            widget = wibox.widget.imagebox,
          },
          margins = dpi(4),
          widget = wibox.container.margin,
        },
        id = "icon_bg",
        shape = gears.shape.circle,
        widget = wibox.container.background,
      },
      widget = clickable_container,
    },
    right = dpi(25),
    widget = wibox.container.margin,
  },
  {
    {
      id = "slider",

      bar_shape = gears.shape.rounded_rect,
      bar_height = dpi(3),
      bar_color = beautiful.cc_slider_volume_bar_inactive_bg
        or beautiful.cc_button_inactive_bg
        or beautiful.cc_button_inactive_default_bg,

      handle_shape = gears.shape.circle,
      handle_width = dpi(12),

      value = 40,
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
      text = "100%",
      widget = wibox.widget.textbox,
    },
    left = dpi(25),
    widget = wibox.container.margin,
  },
  spacing = dpi(15),
  layout = wibox.layout.align.horizontal,
})

local function set_status()
  local vol = os.capture(beautiful.cc_slider_volume_command_get_volume or [=[
    default_sink=$(pulsemixer --list-sinks \
      | grep 'Default' \
      | sed 's/.*ID: \(.*\), Name:.*/\1/g')
    pulsemixer --id ${default_sink} --get-volume | awk '{print $1}'
  ]=])
  local muted = os.capture(beautiful.cc_slider_volume_command_check_mute or [=[
    pulsemixer --list-sinks | grep 'Default' | sed 's/.*Mute: \([01]\).*/\1/'
  ]=])
  local icon = slider_widget:get_children_by_id("icon")[1]
  local icon_bg = slider_widget:get_children_by_id("icon_bg")[1]
  local slider = slider_widget:get_children_by_id("slider")[1]
  local value = slider_widget:get_children_by_id("value")[1]

  if muted:match("1") then
    icon.image = beautiful.cc_slider_volume_muted_icon_path
      or script_path() .. "../icons/volume-muted.svg"

    icon_bg.bg = beautiful.cc_slider_volume_inactive_color
      or beautiful.cc_button_inactive_bg
      or beautiful.cc_button_inactive_default_bg
    slider.bar_active_color = beautiful.cc_slider_volume_inactive_color
      or beautiful.cc_button_inactive_bg
      or beautiful.cc_button_inactive_default_bg
    slider.handle_color = beautiful.cc_slider_volume_inactive_color
      or beautiful.cc_button_inactive_bg
      or beautiful.cc_button_inactive_default_bg
  elseif muted:match("0") then
    icon.image = beautiful.cc_slider_volume_normal_icon_path
      or script_path() .. "../icons/volume-normal.svg"
    icon_bg.bg = beautiful.cc_slider_volume_active_color
      or beautiful.cc_button_active_bg
      or beautiful.cc_button_active_default_bg
    slider.bar_active_color = beautiful.cc_slider_volume_active_color
      or beautiful.cc_button_active_bg
      or beautiful.cc_button_active_default_bg
    slider.handle_color = beautiful.cc_slider_volume_active_color
      or beautiful.cc_button_active_bg
      or beautiful.cc_button_active_default_bg
  end

  slider.value = tonumber(vol)
  value.text = vol .. "%"
end

local toggle_mute = function()
  local muted = os.capture(beautiful.cc_slider_volume_command_check_mute or [=[
    pulsemixer --list-sinks | grep 'Default' | sed 's/.*Mute: \([01]\).*/\1/'
  ]=])

  if muted == "0" then
    awful.spawn.with_shell(
      beautiful.cc_slider_volume_command_mute or "pulsemixer --mute"
    )
  else
    awful.spawn.with_shell(
      beautiful.cc_slider_volume_command_unmute or "pulsemixer --unmute"
    )
  end
  set_status()
end

-- When sliding happens
slider_widget
  :get_children_by_id("slider")[1]
  :connect_signal("property::value", function(_, value)
    awful.spawn.with_shell("pulsemixer --set-volume " .. value)
    slider_widget:get_children_by_id("value")[1].text = value .. "%"
  end)

slider_widget
  :get_children_by_id("icon")[1]
  :connect_signal("button::press", function()
    toggle_mute()
  end)

gears.timer({
  timeout = 5,
  autostart = true,
  call_now = true,
  callback = function()
    set_status()
  end,
})

set_status()

return slider_widget
