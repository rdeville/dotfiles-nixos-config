local awful = require("awful")
local beautiful = require("widgets.theme")
local create_button = require("widgets.control_center.buttons.create-button")

local power_button = create_button.circle_big(
  beautiful.cc_button_power_icon
    or script_path() .. "../icons/system-shutdown.svg"
)

local function set_status(button)
  local background = button:get_children_by_id("background")[1]
  local label = button:get_children_by_id("label")[1]

  background.bg = beautiful.cc_button_power_bg
    or beautiful.cc_button_inactive_bg
    or beautiful.cc_button_inactive_default_bg
  label.text = "Power Off"
end

power_button:connect_signal("button::press", function()
  awful.spawn.easy_sync("poweroff")
end)

set_status(power_button)

return power_button
