---@diagnostic disable undefined-global
local awful = require("awful")
local rofi = require("utils.rofi")
local bling = require("bling")

local modkey = require("config.keys.mod").modkey
local shiftkey = require("config.keys.mod").shiftkey
local ctrlkey = require("config.keys.mod").ctrlkey

return awful.util.table.join(
  awful.key({ modkey }, "f", function(c)
    c.fullscreen = not c.fullscreen
    c:raise()
  end, {
    description = "\t\tToggle fullscreen",
    group = "Client",
  }),

  awful.key({ modkey, ctrlkey }, "c", function(c)
    c:kill()
  end, {
    description = "\t\tSend SIGKILL",
    group = "Client",
  }),

  awful.key({ modkey, ctrlkey }, "space", awful.client.floating.toggle, {
    description = "\tToggle floating",
    group = "Client",
  }),

  awful.key({ modkey }, "a", function(c)
    rofi.prompt({
      p = "New tag name for client",
      dmenu = true,
    }, function(new_name)
      -- Create new tag
      local tag = awful.tag.add(new_name, {
        volatile = true,
        screen = c.screen,
        layout = awful.layout.suit.tile,
      })
      -- Move client to next screen
      c:move_to_tag(tag)
      tag:view_only()
    end)
  end, {
    description = "\t\t\tMove to new tag",
    group = "Tags",
  }),

  awful.key({ modkey }, "o", function(c, _)
    -- Get idx of current tag of client
    local tag = c.screen.tags[c.first_tag.index]
    -- Restore last tag visited
    awful.tag.history.restore()
    -- Move client to next screen
    c:move_to_screen()
    if not awful.tag.find_by_name(c.screen, tag.name) then
      awful.tag.add(tag.name, {
        volatile = true,
        screen = c.screen,
        layout = awful.layout.suit.tile,
      })
    end
    tag = awful.tag.find_by_name(c.screen, tag.name)
    c:move_to_tag(tag)
    c:jump_to()
    awful.tag.history.update(c.screen)
  end, {
    description = "\t\tMove to next screen",
    group = "Client",
  }),

  awful.key({ modkey }, "t", function(c)
    c.ontop = not c.ontop
  end, {
    description = "\t\tToggle keep on top",
    group = "Client",
  }),

  awful.key({ modkey }, "s", function(c)
    c.sticky = not c.sticky
  end, {
    description = "\t\tToggle sticky client",
    group = "Client",
  }),

  awful.key({ modkey }, "n", function(c)
    -- The client currently has the input focus, so it cannot be
    -- minimized, since minimized clients can't have the focus.
    c.minimized = true
  end, {
    description = "\t\tMinimize",
    group = "Client",
  }),

  awful.key({ modkey, shiftkey }, "n", function()
    local c = awful.client.restore()
    -- Focus restored client
    if c then
      client.focus = c
      c:raise()
    end
  end, {
    description = "\t\tRestore minimized",
    group = "Client",
  }),

  awful.key({ modkey }, "m", function(c)
    c.maximized = not c.maximized
    c:raise()
  end, {
    description = "\t\tMaximize",
    group = "Client",
  }),

  awful.key({ modkey, shiftkey }, "t", function(_)
    bling.module.tabbed.pick_with_dmenu()
  end, {
    description = "\t\tPick client to add to tab group",
    group = "Client",
  }),

  awful.key({ modkey }, "Tab", function(_)
    bling.module.tabbed.iter()
  end, {
    description = "\t\tSwitch next client in the tab group",
    group = "Client",
  })
)
