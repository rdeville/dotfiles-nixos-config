local beautiful = require("beautiful")
local colors = require("utils.colors")
local dpi = require("beautiful.xresources").apply_dpi
local shapes = require("utils.shapes")

local default_bg_normal = colors.grey_900
local default_fg_normal = colors.grey_100

local default_bg_focus = colors.green_500
local default_fg_focus = colors.grey_900

local default_bg_urgent = colors.red_500
local default_fg_urgent = colors.grey_900

local default_bg_minimize = colors.purple_500
local default_fg_minimize = colors.grey_900

local default_bg_active = colors.green_500
local default_fg_active = colors.grey_900

local default_bg_inactive = colors.grey_900
local default_fg_inactive = colors.grey_100

local default_bg_connected = colors.orange_500
local default_fg_connected = colors.grey_900

local default_bar_width = dpi(5)

beautiful.default_clr_0 = colors.green_500
beautiful.default_clr_1 = colors.yellow_500
beautiful.default_clr_2 = colors.orange_500
beautiful.default_clr_3 = colors.red_500

beautiful.default_clr_0_inv = beautiful.default_clr_3
beautiful.default_clr_1_inv = beautiful.default_clr_2
beautiful.default_clr_2_inv = beautiful.default_clr_1
beautiful.default_clr_3_inv = beautiful.default_clr_0

beautiful.default_bg_normal = default_bg_normal
beautiful.default_fg_normal = default_fg_normal

beautiful.default_bg_focus = default_bg_focus
beautiful.default_fg_focus = default_fg_focus

beautiful.default_bg_urgent = default_bg_urgent
beautiful.default_fg_urgent = default_fg_urgent

beautiful.default_bg_minimize = default_bg_minimize
beautiful.default_fg_minimize = default_fg_minimize

beautiful.widget_default_bg = default_bg_normal
beautiful.widget_default_fg = default_fg_normal
beautiful.widget_default_shape_right = shapes.powerline_inv
beautiful.widget_default_shape_left = shapes.powerline
beautiful.widget_default_bar_width = default_bar_width
beautiful.widget_default_bar_bg = default_bg_normal

beautiful.cc_button_active_default_bg = default_bg_active
beautiful.cc_button_active_default_fg = default_fg_active
beautiful.cc_button_inactive_default_bg = default_bg_inactive
beautiful.cc_button_inactive_default_fg = default_fg_inactive
beautiful.cc_button_connected_default_bg = default_bg_connected
beautiful.cc_button_connected_default_fg = default_fg_connected
beautiful.cc_button_urgent_default_bg = default_bg_urgent
beautiful.cc_button_urgent_default_fg = default_fg_urgent

beautiful.cc_slider_active_default_bg = default_bg_active
beautiful.cc_slider_active_default_fg = default_fg_active
beautiful.cc_slider_inactive_default_bg = default_bg_inactive
beautiful.cc_slider_inactive_default_fg = default_fg_inactive
beautiful.cc_slider_connected_default_bg = default_bg_connected
beautiful.cc_slider_connected_default_fg = default_fg_connected

beautiful.cc_notif_normal_default_bg = default_bg_focus
beautiful.cc_notif_normal_default_fg = default_fg_focus
beautiful.cc_notif_critical_default_bg = default_bg_urgent
beautiful.cc_notif_critical_default_fg = default_fg_normal

return beautiful
