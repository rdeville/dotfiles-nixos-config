local awful = require("awful")
local beautiful = require("widgets.theme")
local create_button = require("widgets.control_center.buttons.create-button")

local airplane_button = create_button.circle_big(
  beautiful.cc_button_airplane_icon or script_path() .. "../icons/airplane.svg"
)

local function set_status(button)
  local background = button:get_children_by_id("background")[1]
  local label = button:get_children_by_id("label")[1]

  awful.spawn.easy_async(
    beautiful.cc_button_airplane_command_check or "rfkill list all -o SOFT",
    function(stdout)
      if stdout:match("blocked") and stdout:match("unblocked") then
        background.bg = beautiful.cc_button_airplane_inactive
          or beautiful.cc_button_inactive_bg
          or beautiful.cc_button_inactive_default_bg
        label.text = "Off"
      else
        background.bg = beautiful.cc_button_airplane_active
          or beautiful.cc_button_active_bg
          or beautiful.cc_button_active_default_bg
        label.text = "On"
      end
    end
  )
end

airplane_button:connect_signal("button::press", function(self)
  if self:get_children_by_id("label")[1].text == "On" then
    awful.spawn.with_shell(
      beautiful.cc_button_airplane_command_block or "rfkill block all"
    )
  else
    awful.spawn.with_shell(
      beautiful.cc_button_airplane_command_unblock or "rfkill unblock all"
    )
  end
  set_status(self)
end)

set_status(airplane_button)

return airplane_button
