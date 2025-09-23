---@diagnostic disable undefined-global
local awful = require("awful")
local gears = require("gears")

local modkey = require("config.keys.mod").modkey

return gears.table.join(
  awful.button(
    {},
    1, --Left click
    function(t)
      t:view_only()
    end
  ),
  awful.button(
    { modkey },
    1, --Left click
    function(t)
      if client.focus then
        client.focus:move_to_tag(t)
      end
    end
  ),
  awful.button(
    {},
    3, -- Right click
    awful.tag.viewtoggle
  ),
  awful.button(
    {},
    4, -- Scroll up
    function(t)
      awful.tag.viewnext(t.screen)
    end
  ),
  awful.button(
    {},
    5, -- Scroll down
    function(t)
      awful.tag.viewprev(t.screen)
    end
  )
)
