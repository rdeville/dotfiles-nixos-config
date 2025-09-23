local colors = require("utils.colors")
local dpi = require("beautiful.xresources").apply_dpi
local utils = require("theme.utils")
local wibox = require("wibox")

local theme_dir = script_path()

local global = {
  fg_main = colors.grey_100,
  bg_main = colors.green_500,

  fg_normal = colors.grey_300,
  bg_normal = colors.green_700,

  bg_urgent = colors.red_500,
  bg_focus = colors.light_green_a400,

  bg_dark = colors.grey_700,
  bg_darker = colors.grey_800,
  bg_darkest = colors.grey_900,

  font_name = "FiraCode Nerd Font",
  font_size = "10",

  cc_font_size = "8",
}

---@diagnostic disable-next-line lowercase-global
function theme(custom_global)
  return {
    -- Merge with globals
    -- ------------------------------------------------------------------------
    fg_normal = custom_global.fg_normal,
    bg_normal = custom_global.bg_normal,

    bg_urgent = custom_global.bg_urgent,
    bg_focus = custom_global.bg_focus,

    -- Base beautiful variables
    -- ------------------------------------------------------------------------
    font = custom_global.font_name .. " " .. custom_global.font_size,
    useless_gap = dpi(5),

    -- Control Center
    -- ------------------------------------------------------------------------
    cc_font = (custom_global.cc_font_name or custom_global.font_name)
      .. " "
      .. (custom_global.cc_font_size or custom_global.font_size),

    -- Set wallpaper
    -- Static, i.e. path to the image
    wallpaper = theme_dir .. "/wallpapers/wallpaper_1.png",

    -- Border variables
    -- ------------------------------------------------------------------------
    border_width = custom_global.border_width or dpi(2),
    border_normal = custom_global.bg_dark,
    border_focus = custom_global.bg_focus,
    border_urgent = custom_global.bg_urgent,

    -- Hotkeys
    -- ------------------------------------------------------------------------
    hotkeys_bg = custom_global.bg_darker,
    hotkeys_fg = custom_global.fg_normal,
    hotkeys_border_width = custom_global.border_width,
    hotkeys_border_color = custom_global.bg_main,
    hotkeys_modifiers_fg = colors.yellow_500,
    hotkeys_label_bg = custom_global.bg_darkest,
    hotkeys_label_fg = custom_global.fg_normal,
    hotkeys_group_margin = 10,

    -- Naughty notification
    -- ------------------------------------------------------------------------
    notification_bg = custom_global.bg_normal,
    notification_fg = custom_global.fg_normal,
    notification_border_color = custom_global.bg_focus,

    -- Wibar
    -- ------------------------------------------------------------------------
    wibar_height = 20,
    wibar_bg = custom_global.bg_main .. "44",

    -- Right Widgets
    -- ------------------------------------------------------------------------
    bat_bg = custom_global.bg_darker,
    net_bg = custom_global.bg_darker,
    cpu_bg = custom_global.bg_darker,
    cc_bg = custom_global.bg_darker,

    -- Control Center widget variables
    -- ------------------------------------------------------------------------
    cc_user_name = "Tikka",
    cc_user_icon = theme_dir .. "icons/control_center/user_light.svg",
  }
end

local function top_left_wibar(screen, spacing)
  return {
    require("widgets.systray"),
    require("widgets.taglist")(screen),
    spacing = -dpi(spacing),
    layout = wibox.layout.fixed.horizontal,
  }
end

local function top_center_wibar(screen, spacing)
  return {
    require("widgets.tasklist")(screen, spacing),
    layout = wibox.layout.flex.horizontal,
  }
end

local function top_right_wibar(screen, spacing)
  return {
    spacing = -dpi(spacing),
    layout = wibox.layout.fixed.horizontal,
    require("widgets.keyboardlayout")(),
    require("widgets.bat")(),
    require("widgets.uptime")(),
    require("widgets.net")(),
    require("widgets.ram")(),
    require("widgets.cpu")(),
    require("widgets.date")(),
    require("widgets.control_center")(screen),
    require("widgets.layouts")(),
  }
end

return {
  global = global,
  theme = theme,
  top_left_wibar = top_left_wibar,
  top_center_wibar = top_center_wibar,
  top_right_wibar = top_right_wibar,
}
