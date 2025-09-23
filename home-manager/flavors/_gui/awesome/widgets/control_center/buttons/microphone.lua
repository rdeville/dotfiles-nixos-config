local awful = require("awful")
local beautiful = require("widgets.theme")
local create_button = require("widgets.control_center.buttons.create-button")

local microphone_button = create_button.circle_big(
  beautiful.cc_button_microphone_icon
    or script_path() .. "../icons/microphone.svg"
)

local command_check = beautiful.cc_button_microphone_command_check
  or "pulsemixer --list-sources"

local function set_status(button)
  local background = button:get_children_by_id("background")[1]
  local label = button:get_children_by_id("label")[1]

  awful.spawn.easy_async(command_check, function(stdout)
    if stdout:match("Mute: 0") then
      background.bg = beautiful.cc_button_microphone_active_bg
        or beautiful.cc_button_active_bg
        or beautiful.cc_button_active_default_bg
      label.text = "On"
    else
      background.bg = beautiful.cc_button_microphone_inactive
        or beautiful.cc_button_inactive_bg
        or beautiful.cc_button_inactive_default_bg
      label.text = "Off"
    end
  end)
end

microphone_button:connect_signal("button::press", function(self)
  local command_mute = beautiful.cc_button_microphone_command_mute
    or [=[
    for source in $(pulsemixer --list-source | sed 's/.*ID: \(.*\), Name:.*/\1/g')
    do
      pulsemixer --id "${source}" --mute
    done ]=]
  local command_unmute = beautiful.cc_button_microphone_command_unmute
    or [=[
    for source in $(pulsemixer --list-source | sed 's/.*ID: \(.*\), Name:.*/\1/g')
    do
      pulsemixer --id "${source}" --unmute
    done ]=]

  awful.spawn.easy_async(command_check, function(stdout)
    if stdout:match("Mute: 0") then
      awful.spawn.easy_async(command_mute)
    else
      awful.spawn.easy_async(command_unmute)
    end
  end)

  set_status(self)
end)

set_status(microphone_button)

return microphone_button
