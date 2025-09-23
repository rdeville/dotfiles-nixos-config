---@diagnostic disable undefined-global
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup.widget")
local gears = require("gears")
local beautiful = require("beautiful")

local modkey = require("config.keys.mod").modkey
local altkey = require("config.keys.mod").altkey
local shiftkey = require("config.keys.mod").shiftkey
local ctrlkey = require("config.keys.mod").ctrlkey

local terminal = require("config.apps").terminal
local browser = require("config.apps").browser
local explorer = require("config.apps").explorer

local rofi = require("utils.rofi")

local globalkeys = gears.table.join(
  -- Hotkeys
  awful.key({ modkey }, "F1", hotkeys_popup.show_help, {
    description = "\t\tShow help",
    group = "Awesome",
  }),
  -- personal widget notification center
  awful.key({ modkey }, "d", function()
    awesome.emit_signal("control-center::toggle")
  end, {
    description = "Show notification center",
    group = "Awesome",
  }),

  -- TAG BROWSING
  -- ==========================================================================
  awful.key({ modkey, shiftkey }, "h", awful.tag.viewprev, {
    description = "\t\t\tView previous tag",
    group = "Tags",
  }),

  awful.key({ modkey, shiftkey }, "l", awful.tag.viewnext, {
    description = "\t\t\tView next tag",
    group = "Tags",
  }),

  awful.key({ modkey, shiftkey }, "r", function()
    local screen = awful.screen.focused()
    local tag = screen.selected_tag
    rofi.prompt({
      p = "Rename tag",
      dmenu = true,
    }, function(new_name)
      tag.name = new_name
    end)
  end, {
    description = "\t\t\tRename current tag",
    group = "Tags",
  }),

  awful.key({ modkey, shiftkey }, "a", function()
    rofi.prompt({
      p = "New tag name",
      dmenu = true,
    }, function(new_name)
      awful.tag.add(new_name):view_only()
    end)
  end, {
    description = "\t\t\tCreate new tag",
    group = "Tags",
  }),

  awful.key({ modkey, shiftkey }, "w", function()
    local screen = awful.screen.focused()
    local tag = screen.selected_tag
    if not tag then
      return
    end
    tag:delete()
  end, {
    description = "\t\t\tDelete current tag",
    group = "Tags",
  }),

  -- CLIENT BROWSING
  -- ==========================================================================
  awful.key({ modkey }, "j", function()
    awful.client.focus.global_bydirection("down")
    if client.focus then
      client.focus:raise()
    end
  end, {
    description = "\t\tFocus down",
    group = "Client",
  }),

  awful.key({ modkey }, "k", function()
    awful.client.focus.global_bydirection("up")
    if client.focus then
      client.focus:raise()
    end
  end, {
    description = "\t\tFocus up",
    group = "Client",
  }),

  awful.key({ modkey }, "h", function()
    awful.client.focus.global_bydirection("left")
    if client.focus then
      client.focus:raise()
    end
  end, {
    description = "\t\tFocus left",
    group = "Client",
  }),

  awful.key({ modkey }, "l", function()
    awful.client.focus.global_bydirection("right")
    if client.focus then
      client.focus:raise()
    end
  end, {
    description = "\t\tFocus right",
    group = "Client",
  }),

  -- CLIENT SIZE
  -- ==========================================================================
  awful.key({ modkey, altkey }, "l", function()
    awful.tag.incmwfact(0.01)
  end, {
    description = "\t\tIncrease client size width factor",
    group = "Screen",
  }),

  awful.key({ modkey, altkey }, "h", function()
    awful.tag.incmwfact(-0.01)
  end, {
    description = "\t\tDecrease client size width factor",
    group = "Screen",
  }),

  awful.key({ modkey }, "space", function()
    awful.layout.inc(1)
  end, {
    description = "\t\tSelect next layout",
    group = "Screen",
  }),

  awful.key({ modkey, "Shift" }, "space", function()
    awful.layout.inc(-1)
  end, {
    description = "\tSelect previous layout",
    group = "Screen",
  }),

  -- LAYOUT MANIPULATION
  -- ==========================================================================
  awful.key({ modkey, shiftkey }, "j", function()
    awful.client.swap.byidx(1)
  end, {
    description = "\t\tSwap with next client by index",
    group = "Client",
  }),

  awful.key({ modkey, shiftkey }, "k", function()
    awful.client.swap.byidx(-1)
  end, {
    description = "\t\tSwap with previous client by index",
    group = "Client",
  }),

  awful.key({ modkey, ctrlkey }, "j", function()
    awful.screen.focus_relative(1)
  end, {
    description = "\t\tFocus the next screen",
    group = "Screen",
  }),

  awful.key({ modkey, ctrlkey }, "k", function()
    awful.screen.focus_relative(-1)
  end, {
    description = "\t\tFocus the previous screen",
    group = "Screen",
  }),

  awful.key({ modkey }, "u", awful.client.urgent.jumpto, {
    description = "\t\tJump to urgent client",
    group = "Client",
  }),

  -- SHOW/HIDE WIBOX
  -- ==========================================================================
  awful.key({ modkey }, "b", function()
    for s in screen do
      s.empty_top_bar.visible = not s.empty_top_bar.visible
      s.top_bar.visible = not s.top_bar.visible
    end
  end, {
    description = "\t\tToggle/Hide top and bottom wibox",
    group = "Screen",
  }),

  -- ON THE FLY GAPS CHANGE
  -- ==========================================================================
  awful.key({ modkey, altkey }, "u", function()
    awful.tag.incgap(1)
  end, {
    description = "\t\tIncrease gap",
    group = "Screen",
  }),
  awful.key({ modkey, altkey }, "d", function()
    awful.tag.incgap(-1)
  end, {
    description = "\t\tDecrease gap",
    group = "Screen",
  }),

  -- STANDARD PROGRAM
  -- ==========================================================================
  awful.key({ modkey, ctrlkey }, "r", awesome.restart, {
    description = "\t\tReload awesome",
    group = "Awesome",
  }),
  awful.key({ modkey, shiftkey }, "q", awesome.quit, {
    description = "\t\tQuit awesome",
    group = "Awesome",
  }),

  -- BRIGHTNESS
  -- ==========================================================================
  awful.key({}, "XF86MonBrightnessUp", function()
    os.execute("xbacklight -inc 10")
    awesome.emit_signal("update::brightness")
  end, {
    description = "\t\tIncrease backlight +10%",
    group = "Hotkeys",
  }),
  awful.key({}, "XF86MonBrightnessDown", function()
    os.execute("xbacklight -dec 10")
    awesome.emit_signal("update::brightness")
  end, {
    description = "\t\tDecrease backlight -10%",
    group = "Hotkeys",
  }),

  -- VOLUME CONTROL
  -- ==========================================================================
  awful.key({}, "XF86AudioRaiseVolume", function()
    os.execute(string.format("pulsemixer --change-volume +5"))
    awesome.emit_signal("update::volume")
  end, {
    description = "\t\tVolume up",
    group = "Hotkeys",
  }),

  awful.key({}, "XF86AudioLowerVolume", function()
    os.execute(string.format("pulsemixer --change-volume -5"))
    awesome.emit_signal("update::volume")
  end, {
    description = "\t\tVolume down",
    group = "Hotkeys",
  }),

  awful.key({}, "XF86AudioMute", function()
    awesome.emit_signal("toggle::mute")
  end, {
    description = "\t\tToggle mute",
    group = "Hotkeys",
  }),

  awful.key({ modkey }, "Up", function()
    os.execute(string.format("pulsemixer --change-volume +5"))
    if beautiful.volume then
      beautiful.volume.update()
    end
  end, {
    description = "\tVolume up",
    group = "Hotkeys",
  }),

  awful.key({ modkey }, "Down", function()
    os.execute(string.format("pulsemixer --change-volume -5"))
    if beautiful.volume then
      beautiful.volume.update()
    end
  end, {
    description = "\tVolume down",
    group = "Hotkeys",
  }),

  awful.key({ modkey, shiftkey }, "m", function()
    os.execute(string.format("pulsemixer --toggle-mute"))
    if beautiful.volume then
      beautiful.volume.update()
    end
  end, {
    description = "\tToggle mute",
    group = "Hotkeys",
  }),

  -- User programs
  -- ==========================================================================
  awful.key({ modkey }, "Return", function()
    awful.spawn(terminal)
  end, {
    description = "\t\tOpen a terminal",
    group = "Applications",
  }),

  -- ==========================================================================
  awful.key({ modkey }, "r", function()
    rofi.prompt({
      show = "run",
      prompt = "Run:",
    })
  end, {
    description = "\t\tRun rofi",
    group = "Applications",
  }),

  awful.key({ modkey }, "e", function()
    awful.spawn.with_shell(script_path() .. "/../../utils/rofi/rofi_emoji")
  end, {
    description = "\t\tRun rofi to select unicode char",
    group = "Applications",
  }),

  awful.key({ modkey }, "i", function()
    awful.spawn.with_shell(script_path() .. "/../../utils/rofi/rofi_gitmoji")
  end, {
    description = "\t\tRun rofi to select unicode char",
    group = "Applications",
  }),

  awful.key({ modkey, altkey }, "k", function()
    rofi.prompt({
      p = "New keyboard layout",
      dmenu = true,
    }, function(new_kbl)
      awful.spawn.with_shell("setxkbmap " .. new_kbl)
    end)
  end, {
    description = "\t\tRun rofi to select keyboard layout",
    group = "Keyboard",
  })
)

for i = 1, 9 do
  globalkeys = gears.table.join(
    globalkeys,
    awful.key({ modkey }, "#" .. i + 9, function()
      local screen = mouse.screen
      local tag = screen.tags[i]
      if tag then
        tag:view_only()
      end
    end, {
      description = "\tSwitch to # tags",
      group = "Tags",
    }),
    awful.key({ modkey, ctrlkey }, "#" .. i + 9, function()
      local screen = mouse.screen
      local tag = screen.tags[i]
      if tag then
        awful.tag.viewtoggle(tag)
      end
    end, {
      description = "\tMerge content of tag # with current one",
      group = "Tags",
    }),
    awful.key({ modkey, shiftkey }, "#" .. i + 9, function()
      if not client.focus then
        return
      end
      local tag = awful.tag.gettags(client.focus.screen)[i]
      if client.focus and tag then
        awful.client.movetotag(tag)
      end
    end, {
      description = "\tSend client to tag #",
      group = "Tags",
    })
  )
end

return globalkeys
