local awful = require("awful")
local beautiful = require("widgets.theme")
local create_button = require("widgets.control_center.buttons.create-button")

local lock_button = create_button.circle_big(
  beautiful.cc_button_lock_icon or script_path() .. "../icons/lock.svg"
)

local function set_status(button)
  local background = button:get_children_by_id("background")[1]
  local label = button:get_children_by_id("label")[1]

  background.bg = beautiful.cc_button_lock_inactive_bg
    or beautiful.cc_button_inactive_bg
    or beautiful.cc_button_inactive_default_bg
  label.text = "Lock"
end

lock_button:connect_signal("button::press", function()
  awful.spawn.easy_async(beautiful.cc_button_lock_command or "i3lock")
end)

set_status(lock_button)

return lock_button
