local awful = require("awful")
local beautiful = require("widgets.theme")
local colors = require("utils.colors")
local dpi = require("beautiful.xresources").apply_dpi
local wibox = require("wibox")

local taglist = {}

local function factory(screen)
  taglist = awful.widget.taglist({
    screen = screen,
    filter = awful.widget.taglist.filter.all,
    buttons = require("config.buttons.taglist"),
    layout = {
      spacing = -dpi(2),
      layout = wibox.layout.flex.horizontal,
    },
    font = beautiful.taglist_font or beautiful.font,
    widget_template = {
      {
        {
          id = "tag",
          widget = wibox.widget.textbox,
        },
        left = 15,
        right = 10,
        widget = wibox.container.margin,
      },
      shape = beautiful.layout_shape or beautiful.widget_default_shape_left,
      forced_width = dpi(beautiful.wibar_height * 3.25),
      widget = wibox.container.background,
      create_callback = function(self, tag, index, objects)
        self:update_callback(tag, index, objects)
      end,
      update_callback = function(self, tag, index)
        local fg, bg = colors.white, colors.black
        if tag.selected then
          fg = beautiful.taglist_fg_focus or colors.black
          bg = beautiful.taglist_bg_focus or colors.light_green_a400
        elseif next(tag:clients()) == nil then
          fg = beautiful.taglist_fg_empty or colors.white
          bg = beautiful.taglist_bg_empty or colors.green_300 .. "44"
        elseif next(tag:clients()) ~= nil then
          fg = beautiful.taglist_fg_occupied or colors.black
          bg = beautiful.taglist_bg_occupied or colors.orange_a400
        elseif tag.volatile then
          fg = beautiful.taglist_fg_volatile or colors.black
          bg = beautiful.taglist_bg_volatile or colors.cyan_a400
        elseif tag.urgent then
          fg = beautiful.taglist_fg_urgent or colors.black
          bg = beautiful.taglist_bg_urgent or colors.red_500
        end

        self.fg = fg
        self.bg = bg
        self:get_children_by_id("tag")[1].text = index .. " " .. tag.name
      end,
    },
  })

  return taglist
end

return setmetatable(taglist, {
  __call = function(_, ...)
    return factory(...)
  end,
})
