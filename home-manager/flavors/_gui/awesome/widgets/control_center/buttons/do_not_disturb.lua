local beautiful = require("widgets.theme")
local create_button = require("widgets.control_center.buttons.create-button")
local naughty = require("naughty")

local dnd_button = create_button.circle_big(
  beautiful.cc_button_do_not_disturb_icon
    or script_path() .. "../icons/notifications.svg"
)

local function set_status(button)
  local background = button:get_children_by_id("background")[1]
  local label = button:get_children_by_id("label")[1]

  if naughty.suspended then
    background.bg = beautiful.cc_button_do_not_disturb_inactive
      or beautiful.cc_button_inactive_bg
      or beautiful.cc_button_inactive_default_bg
    label.text = "Off"
  else
    background.bg = beautiful.cc_button_do_not_disturb_active
      or beautiful.cc_button_active_bg
      or beautiful.cc_button_active_default_bg
    label.text = "On"
  end
end

dnd_button:connect_signal("button::press", function(self)
  naughty.suspended = not naughty.suspended
  set_status(self)
end)

set_status(dnd_button)

return dnd_button
