local awful = require("awful")
local beautiful = require("widgets.theme")
local colors = require("utils.colors")
local dpi = require("beautiful.xresources").apply_dpi
local shapes = require("utils.shapes")
local wibox = require("wibox")

local tasklist = {}

local function factory(screen, spacing)
  tasklist = awful.widget.tasklist({
    screen = screen,
    filter = awful.widget.tasklist.filter.currenttags,
    buttons = require("config.buttons.tasklist"),
    shape = beautiful.tasklist_shape or shapes.powerline,
    font = beautiful.tasklist_font or beautiful.font,
    layout = {
      layout = wibox.layout.fixed.horizontal,
      spacing = spacing,
    },
    widget_template = {
      {
        {
          nil,
          {
            {
              id = "state",
              widget = wibox.widget.textbox,
            },
            awful.widget.clienticon,
            {
              id = "class",
              widget = wibox.widget.textbox,
            },
            spacing = spacing,
            forced_height = 9 * dpi(beautiful.wibar_height / 10),
            widget = wibox.layout.fixed.horizontal,
          },
          {
            id = "bar",
            forced_height = dpi(beautiful.wibar_height / 10),
            widget = wibox.container.background,
          },
          widget = wibox.layout.align.vertical,
        },
        widget = wibox.container.background,
        id = "background",
      },
      widget = wibox.layout.fixed.horizontal,
      create_callback = function(self, c, index, objects)
        self:update_callback(c, index, objects)
      end,
      update_callback = function(self, c, _, _)
        local bg, fg = "", ""

        if c.active then
          bg = beautiful.tasklist_bg_focus or colors.green_a700
          fg = beautiful.tasklist_fg_focus or colors.white
        elseif c.minimized then
          bg = beautiful.tasklist_bg_minimize or colors.purple_a700
          fg = beautiful.tasklist_bg_minimize or colors.purple_a700
        elseif c.urgent then
          bg = beautiful.tasklist_bg_urgent or colors.red_a700
          fg = beautiful.tasklist_bg_urgent or colors.red_a700
        else
          bg = beautiful.tasklist_bg_normal or colors.grey_900
          fg = beautiful.tasklist_fg_normal or colors.grey_900
        end

        self:get_children_by_id("background")[1].fg = fg
        self:get_children_by_id("bar")[1].bg = bg
        self:get_children_by_id("class")[1].text = c.class
        self:get_children_by_id("state")[1].text = ""
          .. (c.sticky and (beautiful.tasklist_sticky or " ") or "")
          .. (c.ontop and (beautiful.tasklist_ontop or "󰝕 ") or "")
          .. (c.floating and (beautiful.tasklist_floating or " ") or "")
          .. (c.maximized and (beautiful.tasklist_maximized or " ") or "")
          .. (c.minimized and (beautiful.tasklist_minimized or " ") or "")
      end,
    },
  })

  return tasklist
end

return setmetatable(tasklist, {
  __call = function(_, ...)
    return factory(...)
  end,
})
