local beautiful = require("widgets.theme")
local create_button = require("widgets.control_center.buttons.create-button")

local logout_button = create_button.circle_big(
  beautiful.cc_button_logout_icon or script_path() .. "../icons/logout.svg"
)

local function initial_action(button)
  local background = button:get_children_by_id("background")[1]
  local label = button:get_children_by_id("label")[1]

  background.bg = beautiful.cc_button_logout_inactive_bg
    or beautiful.cc_button_inactive_bg
    or beautiful.cc_button_inactive_default_bg
  label.text = "Sign Out"
end

logout_button:connect_signal("button::press", function()
  ---@diagnostic disable-next-line:undefined-global
  awesome.quit()
end)

initial_action(logout_button)

return logout_button
