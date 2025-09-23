local ruled = require("ruled")
local awful = require("awful")

-- Notifications
ruled.notification.connect_signal("request::rules", function()
  -- All notifications will match this rule.
  ruled.notification.append_rule({
    properties = {
      screen = awful.screen.focused,
      timeout = 10,
    },
  })
end)
