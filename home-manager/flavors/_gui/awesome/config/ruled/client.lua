---@diagnostic disable undefined-global
local awful = require("awful")
local beautiful = require("beautiful")
local ruled = require("ruled")
local gears = require("gears")
local dpi = require("beautiful.xresources").apply_dpi

local clientkeys = require("config.keys.client")
local clientbuttons = require("config.buttons.client")
local tagname = require("config.tags").name

local function default_callback(screen, tag, volatile)
  volatile = volatile or false

  require("naughty").notify({
    preset = fs_notification_preset,
    title = "bar",
    text = screen.tags,
    icon = beautiful.cc_popup_default_btn_icon,
    timeout = 5,
    screen = mouse.screen,
  })

  if not awful.tag.find_by_name(screen, tag) then
    awful.tag.add(tag, {
      volatile = volatile,
      screen = screen,
    })
  end
end

local function set_screen(preferred, default)
  if screen.count() >= 3 then
    return preferred
  end
  return default
end

ruled.client.append_rules({
  -- All clients will match this rule.
  {
    rule = {},
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = clientkeys,
      buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
      size_hints_honor = false,
    },
  },
  -- Add titles bars to dialog client
  {
    rule_any = { type = { "dialog" } },
    properties = {
      tag = awful.screen.focused().selected_tag,
      floating = true,
      width = dpi(640),
      shape = function(cr, width, height)
        return gears.shape.rounded_rect(cr, width, height, dpi(5))
      end,
    },
    callback = function(c, _)
      c:move_to_tag(client.focus.screen.tags[awful.tag.getidx()])
      awful.placement.centered(c, nil)
    end,
  },
  -- Add titles bars to floating client
  {
    rule_any = { type = { "floating" } },

    properties = {
      shape = function(cr, width, height)
        return gears.shape.rounded_rect(cr, width, height, dpi(5))
      end,
    },
  },
  {
    rule_any = { class = { "kitty", "alacritty" } },
    properties = {
      tag = tagname.terminal,
      switch_to_tags = true,
    },
  },
  {
    rule_any = { role = { "browser" } },
    properties = {
      tag = tagname.browser,
      switch_to_tags = true,
    },
  },
  {
    rule_any = { class = { "Mail", "thunderbird" } },
    callback = function(_, properties)
      if properties then
        default_callback(properties.screen, properties.tag, properties.volatile)
      end
    end,
    properties = {
      name = tagname.mail,
      tag = tagname.mail,
      switch_to_tags = true,
      screen = set_screen(3, 1), -- left or center
    },
  },
  {
    rule_any = {
      class = { "keepassxc", "KeePassXC" },
    },
    except_any = {
      {
        name = "Auto-Type - KeePassXC",
      },
      {
        name = "Unlock Database - KeePassXC",
      },
    },
    properties = {
      tag = tagname.pass,
      switch_to_tags = true,
    },
  },
  {
    rule_any = { class = { "libreoffice", "libreoffice-startcenter" } },
    callback = function(_, properties)
      if properties then
        default_callback(properties.screen, properties.tag, properties.volatile)
      end
    end,
    properties = {
      tag = tagname.office,
      switch_to_tags = true,
      new_tag = {
        name = tagname.office,
        layout = awful.layout.suit.tile,
        volatile = true,
      },
    },
  },
  {
    rule_any = { class = { "explorer" }, instance = { "Thunar", "pcmanfm" } },
    callback = function(_, properties)
      if properties then
        default_callback(properties.screen, properties.tag, properties.volatile)
      end
    end,
    properties = {
      tag = tagname.filemanager,
      switch_to_tags = true,
      new_tag = {
        name = tagname.filemanager,
        layout = awful.layout.suit.tile,
        volatile = true,
      },
    },
  },
  {
    rule_any = { class = { "Steam", "discord" }, name = { "Discord" } },
    callback = function(_, properties)
      if properties then
        default_callback(properties.screen, properties.tag, properties.volatile)
      end
    end,
    properties = {
      tag = tagname.steam,
      switch_to_tags = true,
      screen = set_screen(3, 1), -- left or center
      new_tag = {
        name = tagname.steam,
        layout = awful.layout.suit.tile,
        volatile = true,
      },
    },
  },
  {
    rule_any = { class = { "Signal", "whatsdesk" } },
    callback = function(_, properties)
      if properties then
        default_callback(properties.screen, properties.tag, properties.volatile)
      end
    end,
    properties = {
      tag = tagname.chat,
      switch_to_tags = true,
      screen = set_screen(3, 1), -- left or center
      new_tag = {
        name = tagname.chat,
        layout = awful.layout.suit.tile,
        volatile = true,
      },
    },
  },
  {
    rule_any = { class = { "Inkscape" } },
    callback = function(_, properties)
      if properties then
        default_callback(properties.screen, properties.tag, properties.volatile)
      end
    end,
    properties = {
      tag = tagname.inkscape,
      switch_to_tags = true,
      new_tag = {
        name = tagname.inkscape,
        layout = awful.layout.suit.tile,
        volatile = true,
      },
    },
  },
  {
    rule_any = { class = { "Gimp" } },
    callback = function(_, properties)
      if properties then
        default_callback(properties.screen, properties.tag, properties.volatile)
      end
    end,
    properties = {
      tag = tagname.gimp,
      switch_to_tags = true,
      new_tag = {
        name = tagname.gimp,
        layout = awful.layout.suit.tile,
        volatile = true,
      },
    },
  },
})
