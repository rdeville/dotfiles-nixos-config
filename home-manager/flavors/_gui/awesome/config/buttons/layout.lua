local awful = require("awful")
local gears = require("gears")

return gears.table.join(
  awful.button(
    {},
    1, --Left click
    function()
      awful.layout.inc(1)
    end
  ),
  awful.button(
    {},
    3, --Right Click
    function()
      awful.layout.inc(-1)
    end
  ),
  awful.button(
    {},
    4, --Scroll up
    function()
      awful.layout.inc(1)
    end
  ),
  awful.button(
    {},
    5, --Scroll down
    function()
      awful.layout.inc(-1)
    end
  )
)
