local awful = require("awful")
local beautiful = require("widgets.theme")
local wibox = require("wibox")

local layout = {}

local layout_img_dir = script_path() .. "icons/layouts/"
beautiful.layout_cornernw = layout_img_dir .. "cornernw.png"
beautiful.layout_cornerne = layout_img_dir .. "cornerne.png"
beautiful.layout_cornersw = layout_img_dir .. "cornersw.png"
beautiful.layout_cornerse = layout_img_dir .. "cornerse.png"
beautiful.layout_fairh = layout_img_dir .. "fairhorizontal.png"
beautiful.layout_fairv = layout_img_dir .. "fair.png"
beautiful.layout_floating = layout_img_dir .. "floating.png"
beautiful.layout_magnifier = layout_img_dir .. "magnifier.png"
beautiful.layout_fullscreen = layout_img_dir .. "fullscreen.png"
beautiful.layout_tiletop = layout_img_dir .. "tiletop.png"
beautiful.layout_tilebottom = layout_img_dir .. "tilebottom.png"
beautiful.layout_tileleft = layout_img_dir .. "tileleft.png"
beautiful.layout_max = layout_img_dir .. "max.png"
beautiful.layout_tile = layout_img_dir .. "tile.png"
-- Recolor img assets to fg_normal
require("beautiful.theme_assets").recolor_layout(
  beautiful,
  beautiful.layout_fg or beautiful.widget_default_fg
)

local function factory(screen)
  layout = wibox.widget({
    {
      awful.widget.layoutbox({
        screen = screen,
        buttons = require("config.buttons.layout"),
      }),
      widget = wibox.container.margin(nil, 15, 15, 0, 0),
    },
    fg = beautiful.layout_fg or beautiful.widget_default_fg,
    bg = beautiful.layout_bg or beautiful.widget_default_bg,
    font = beautiful.layout_font or beautiful.font,
    shape = beautiful.layout_shape or beautiful.widget_default_shape_right,
    widget = wibox.container.background,
  })

  return layout
end

return setmetatable(layout, {
  __call = function(_, ...)
    return factory(...)
  end,
})
