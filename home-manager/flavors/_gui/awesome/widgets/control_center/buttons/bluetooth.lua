local awful = require("awful")
local beautiful = require("widgets.theme")
local create_button = require("widgets.control_center.buttons.create-button")
local gears = require("gears")

local bluetooth_button = create_button.circle_big(
  beautiful.cc_button_bluetooth_icon
    or script_path() .. "../icons/bluetooth.svg"
)

local function set_status()
  local background = bluetooth_button:get_children_by_id("background")[1]
  local label = bluetooth_button:get_children_by_id("label")[1]

  local state = os.capture("rfkill list bluetooth")
  if state:match("Soft blocked: yes") or state:match("Hard blocked: yes") then
    background.bg = beautiful.cc_button_bluetooth_inactive
      or beautiful.cc_button_inactive_bg
      or beautiful.cc_button_inactive_default_bg
    label.text = "Off"
  else
    awful.spawn.easy_async_with_shell(
      "bluetoothctl devices Connected",
      function(output)
        if output == "" or output == nil then
          background.bg = beautiful.cc_button_bluetooth_active
            or beautiful.cc_button_active_bg
            or beautiful.cc_button_active_default_bg
          label.text = "On"
        else
          background.bg = beautiful.cc_button_bluetooth_connected
            or beautiful.cc_button_connected_bg
            or beautiful.cc_button_connected_default_bg
          label.text = "Connected"
        end
      end
    )
  end
end

gears.timer({
  timeout = 5,
  autostart = true,
  call_now = true,
  callback = function()
    set_status()
  end,
})

bluetooth_button:connect_signal("button::press", function(self)
  local label = self:get_children_by_id("label")[1]

  awful.spawn.easy_async("rfkill list bluetooth", function(stdout)
    if stdout:match("Soft blocked: yes") then
      awful.spawn.with_shell("rfkill unblock bluetooth")
      label.text = "Go on..."
    else
      awful.spawn.with_shell("rfkill block bluetooth")
      label.text = "Go off..."
    end
  end)
end)

set_status()

return bluetooth_button
