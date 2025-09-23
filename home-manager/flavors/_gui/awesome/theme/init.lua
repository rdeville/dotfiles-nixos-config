local awful = require("awful")
local dpi = require("beautiful.xresources").apply_dpi
local gears = require("gears")
local utils = require("theme.utils")
local wibox = require("wibox")

local host
local hostname = utils.hostname()
local file = io.open(script_path() .. "/hosts/" .. hostname .. ".lua", "r")

if file ~= nil then
  io.close(file)
  host = require("theme.hosts." .. hostname)
else
  host = {
    global = nil,
    theme = nil,
    top_left_wibar = nil,
    top_center_wibar = nil,
    top_right_wibar = nil,
  }
end

local default = require("theme.default")
local global = host.global ~= nil
    and utils.merge_config(default.global, host.global)
  or default.global
local theme = host.theme ~= nil
    and utils.merge_config(default.theme(global), host.theme(global))
  or default.theme(global)
-- Recolor img assets to fg_normal
require("beautiful.theme_assets").recolor_layout(theme, global.fg_normal)

function theme.at_screen_connect(s)
  -- Time based wallpaper configuration
  gears.timer({
    timeout = 300,
    call_now = true,
    autostart = true,
  })
  awful.tag(awful.util.tagnames, s, awful.layout.layouts)

  -- Empty top wibar to create a "margin"
  s.empty_top_bar = awful.wibar({
    position = "top",
    screen = s,
    height = dpi(theme.wibar_height / 2),
    bg = "#00000000",
  })
  -- The real top wibar
  s.top_bar = awful.wibar({
    position = "top",
    screen = s,
    height = dpi(theme.wibar_height),
    width = s.geometry.width - 4 * theme.useless_gap,
    fg = theme.wibar_fg,
    bg = theme.wibar_bg,
  })

  s.top_bar:setup({
    layout = wibox.layout.align.horizontal,
    host.top_left_wibar ~= nil
        and host.top_left_wibar(s, theme.wibar_height / 4)
      or default.top_left_wibar(s, theme.wibar_height / 4),
    host.top_center_wibar ~= nil
        and host.top_center_wibar(s, theme.wibar_height / 4)
      or default.top_center_wibar(s, theme.wibar_height / 4),
    host.top_right_wibar ~= nil
        and host.top_right_wibar(s, theme.wibar_height / 4)
      or default.top_right_wibar(s, theme.wibar_height / 4),
  })
end

return theme
