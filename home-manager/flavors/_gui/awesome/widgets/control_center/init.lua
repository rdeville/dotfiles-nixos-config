local awful = require("awful")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi
local gears = require("gears")
local shapes = require("utils.shapes")
local wibox = require("wibox")

local control_center = function(s)
  local control_widget = wibox.widget({
    {
      {
        text = beautiful.cc_icon or "󰉺 ",
        widget = wibox.widget.textbox,
      },
      widget = wibox.container.margin(nil, 15, 15, 0, 0),
    },
    bg = beautiful.cc_bg or beautiful.widget_default_bg,
    fg = beautiful.cc_fg or beautiful.widget_default_fg,
    shape = beautiful.cch_shape or shapes.powerline_inv,
    widget = wibox.container.background,
  })

  local control_popup = awful.popup({
    widget = {},
    bg = beautiful.cc_popup_bg or beautiful.cc_bg or beautiful.widget_default_bg,
    fg = beautiful.cc_popup_fg or beautiful.cc_fg or beautiful.widget_default_fg,
    shape = beautiful.cc_popup_shape or gears.shape.rounded_rect,
    ontop = true,
    -- Hide control center by default
    visible = false,
    screen = s,
    placement = function(w)
      awful.placement.top_right(w, {
        margins = {
          left = 0,
          top = beautiful.wibar_height * 1.75,
          bottom = 0,
          right = beautiful.useless_gap,
        },
      })
    end,
  })

  control_popup:setup({
    {
      {
        require("widgets.control_center.buttons.user"),
        {
          -- Session buttons rows
          require("widgets.control_center.buttons.lock"),
          require("widgets.control_center.buttons.logout"),
          require("widgets.control_center.buttons.power"),
          layout = wibox.layout.flex.horizontal,
        },
        {
          -- Connectivity buttons and others rows
          require("widgets.control_center.buttons.airplane"),
          -- require("widgets.control_center.buttons.bluetooth"),
          require("widgets.control_center.buttons.network"),
          require("widgets.control_center.buttons.do_not_disturb"),
          require("widgets.control_center.buttons.redshift"),
          widget = wibox.layout.flex.horizontal,
        },
        {
          -- Sliders rows
          require("widgets.control_center.sliders.brightness"),
          require("widgets.control_center.sliders.volume"),
          require("widgets.control_center.sliders.microphone"),
          spacing = dpi(10),
          layout = wibox.layout.fixed.vertical,
        },
        -- Notif Center
        require("widgets.control_center.notif_center"),
        spacing = dpi(20),
        layout = wibox.layout.fixed.vertical,
      },
      widget = wibox.container.margin(nil, 25, 25, 25, 25),
    },
    forced_width = s.geometry.width / 5,
    forced_height = s.geometry.height - (beautiful.wibar_height * 2),
    widget = wibox.container.background,
  })

  control_widget:connect_signal("button::press", function()
    control_popup.visible = not control_popup.visible
  end)

  ---@diagnostic disable-next-line:undefined-global
  awesome.connect_signal("control-center::toggle", function()
    control_popup.visible = not control_popup.visible
  end)

  return control_widget
end

return control_center
