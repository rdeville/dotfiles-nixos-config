local awful = require("awful")
local beautiful = require("widgets.theme")
local create_button = require("widgets.control_center.buttons.create-button")

local redshift_button = create_button.circle_big(
  beautiful.cc_button_redshift_icon or script_path() .. "../icons/redshift.svg"
)

local function set_status(button)
  local background = button:get_children_by_id("background")[1]
  local label = button:get_children_by_id("label")[1]

  if label.text == "Off" then
    background.bg = beautiful.cc_button_redshift_active
      or beautiful.cc_button_active_bg
      or beautiful.cc_button_inactive_default_bg
    label.text = "On"
  else
    background.bg = beautiful.cc_button_redshift_inactive
      or beautiful.cc_button_inactive_bg
      or beautiful.cc_button_inactive_default_bg
    label.text = "Off"
  end
end

redshift_button:connect_signal("button::press", function(self)
  if self:get_children_by_id("label")[1].text == "Off" then
    awful.util.spawn("redshift")
  else
    awful.util.spawn("pkill redshift")
  end
  set_status(self)
end)

set_status(redshift_button)

return redshift_button
