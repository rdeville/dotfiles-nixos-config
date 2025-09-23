---@diagnostic disable undefined-global
-- Awesome libraries
-- Widget library
require("awful.autofocus")
require("gears")
require("naughty")
require("awful.rules")
-- Personal tools, mainly for run_once method
require("utils.utility")

local awful = require("awful")
-- Set awful sh application
awful.util.shell = "zsh"
-- Set taglist, layous and tasklist
awful.util.tagnames = require("config.tags").tags
awful.layout.layouts = require("config.layouts")
awful.util.tasklist_buttons = require("config.buttons.tasklist")

-- Theme library
local beautiful = require("beautiful")
beautiful.init(require("theme"))

-- Virtual Desktop
-- ------------------------------------------------------------------------
-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s)
  -- Apply theme to each screen
  beautiful.at_screen_connect(s)
end)

-- Set key bindings
require("config.keys.client")
root.keys(require("config.keys.global"))

-- Set Signals
require("config.signals.naughty")
require("config.signals.screen")
require("config.signals.tag")
require("config.signals.client")
require("config.signals.ruled")

-- Set rules for client and notification
require("config.ruled.client")

-- STARTUP RUN ONCE
-- ------------------------------------------------------------------------
run_once({
  "picom",
  "keynav",
  "nextcloud",
  --"xautolock -time 180 -locker ~/.bin/lock &", -- lock the screen after 180 sec on inactivity
})
