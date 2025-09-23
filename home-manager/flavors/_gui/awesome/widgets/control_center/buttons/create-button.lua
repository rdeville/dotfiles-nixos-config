local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("widgets.theme")
local dpi = beautiful.xresources.apply_dpi
local clickable_container =
  require("widgets.control_center.clickable-container")

local create_button = {}

--- Creates big size circle button
function create_button.circle_big(icon_path)
  return wibox.widget({
    {
      {
        {
          {
            {
              id = "icon",
              image = icon_path,
              resize = true,
              forced_width = dpi(18),
              forced_height = dpi(18),
              widget = wibox.widget.imagebox,
            },
            margins = dpi(10),
            widget = wibox.container.margin,
          },
          id = "background",
          shape = gears.shape.circle,
          widget = wibox.container.background,
        },
        valign = "center",
        halign = "center",
        widget = wibox.container.place,
      },
      {
        id = "label",
        align = "center",
        valign = "center",
        font = beautiful.cc_font or beautiful.font,
        widget = wibox.widget.textbox,
      },
      spacing = dpi(5),
      layout = wibox.layout.fixed.vertical,
    },
    widget = clickable_container,
  })
end

return create_button
