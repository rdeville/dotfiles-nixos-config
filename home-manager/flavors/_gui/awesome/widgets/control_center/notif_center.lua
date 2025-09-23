local awful = require("awful")
local beautiful = require("beautiful")
local clickable_container =
  require("widgets.control_center.clickable-container")
local dpi = require("beautiful").xresources.apply_dpi
local gears = require("gears")
local naughty = require("naughty")
local wibox = require("wibox")

local function time_to_seconds(time)
  local hourInSec = tonumber(string.sub(time, 1, 2)) * 3600
  local minInSec = tonumber(string.sub(time, 4, 5)) * 60
  local getSec = tonumber(string.sub(time, 7, 8))
  return (hourInSec + minInSec + getSec)
end

local function scroller(widget)
  widget:buttons(gears.table.join(
    awful.button({}, 4, nil, function()
      if #widget.children == 1 then
        return
      end
      widget:insert(1, widget.children[#widget.children])
      widget:remove(#widget.children)
    end),
    awful.button({}, 5, nil, function()
      if #widget.children == 1 then
        return
      end
      widget:insert(#widget.children + 1, widget.children[1])
      widget:remove(1)
    end)
  ))
end

local empty_notifbox = wibox.widget({
  {
    {
      {
        image = beautiful.cc_notif_empty_icon
          or script_path() .. "icons/notifications.svg",
        forced_height = dpi(32),
        forced_width = dpi(32),
        opacity = 0.5,
        widget = wibox.widget.imagebox,
      },
      {
        markup = "<b>You have no more notification</b>",
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox,
      },
      layout = wibox.layout.fixed.horizontal,
      spacing = dpi(5),
    },
    widget = wibox.container.margin(nil, 0, 0, 20, 20),
  },
  valing = "center",
  aling = "center",
  widget = wibox.container.place,
})

local notifbox_layout = wibox.widget({
  empty_notifbox,
  spacing = dpi(10),
  widget = wibox.layout.fixed.vertical,
})

local function create_notifbox(notif)
  local pop_time = os.date("%H:%M:%S")
  local exact_time = os.date("%I:%M %p")
  local exact_date_time = os.date("%b %d, %H:%M:%S")

  local box = wibox.widget({
    {
      {
        {
          {
            {
              image = notif.app_icon,
              resize = true,
              forced_height = dpi(16),
              forced_width = dpi(16),
              widget = wibox.widget.imagebox,
            },
            {
              markup = "<b>" .. (notif.app_name or "System Notification") .. "</b>" ,
              align = "center",
              valign = "center",
              widget = wibox.widget.textbox,
            },
            spacing = dpi(10),
            layout = wibox.layout.fixed.horizontal,
          },
          nil,
          {
            {
              id = "notifbox_time",
              text = pop_time,
              font = beautiful.font,
              widget = wibox.widget.textbox,
            },
            {
              {
                {
                  image = beautiful.cc_notif_dismiss
                    or script_path() .. "icons/remove.svg",
                  resize = true,
                  forced_height = dpi(16),
                  widget = wibox.widget.imagebox,
                },
                bg = beautiful.cc_button_notif_dismiss_bg
                  or beautiful.cc_button_urgent_bg
                  or beautiful.cc_button_urgent_default_bg,
                shape = gears.shape.circle,
                widget = wibox.container.background,
              },
              id = "notifbox_dismiss",
              visible = false,
              widget = clickable_container,
            },
            layout = wibox.layout.align.horizontal,
          },
          id = "notifbox_header",
          expand = "inside",
          layout = wibox.layout.align.horizontal,
        },
        {
          markup = "<b>" .. notif.title .. "</b>",
          widget = wibox.widget.textbox,
        },
        {
          text = notif.message,
          widget = wibox.widget.textbox,
        },
        spacing = dpi(5),
        layout = wibox.layout.fixed.vertical,
      },
      widget = wibox.container.margin(nil, 5, 5, 5, 5),
    },
    bg = notif.bg,
    fg = notif.fg,
    shape = beautiful.cc_notifbox_shape,
    widget = wibox.container.background,
  })

  box:connect_signal("mouse::enter", function()
    box:get_children_by_id("notifbox_dismiss")[1].visible = true
    box:get_children_by_id("notifbox_time")[1].visible = false
  end)

  box:connect_signal("mouse::leave", function()
    box:get_children_by_id("notifbox_dismiss")[1].visible = false
    box:get_children_by_id("notifbox_time")[1].visible = true
  end)

  box
    :get_children_by_id("notifbox_dismiss")[1]
    :connect_signal("button::press", function(_)
      notifbox_layout:remove_widgets(box)
    end)

  -- Update notification time
  gears.timer({
    timeout = 60,
    call_now = true,
    autostart = true,
    callback = function()
      local time_difference = nil

      time_difference = time_to_seconds(os.date("%H:%M:%S"))
        - time_to_seconds(pop_time)
      time_difference = tonumber(time_difference)

      if time_difference < 60 then
        box:get_children_by_id("notifbox_time").text = "now"
      elseif time_difference >= 60 and time_difference < 3600 then
        box:get_children_by_id("notifbox_time").text = math.floor(
          time_difference / 60
        ) .. "m ago"
      elseif time_difference >= 3600 and time_difference < 86400 then
        box:get_children_by_id("notifbox_time").text = exact_time
      elseif time_difference >= 86400 then
        box:get_children_by_id("notifbox_time").text = exact_date_time
      end

      collectgarbage("collect")
    end,
  })

  collectgarbage("collect")

  return box
end

local notif_center = wibox.widget({
  {
    {
      align = "center",
      valign = "center",
      widget = wibox.widget.textbox,
      font = beautiful.cc_font or beautiful.font,
      text = "Notifications",
    },
    nil,
    {
      {
        {
          {
            id = "icon",
            image = beautiful.cc_notif_clear_all_icon
              or script_path() .. "/icons/clear-all.svg",
            resize = true,
            forced_height = dpi(16),
            forced_width = dpi(16),
            widget = wibox.widget.imagebox,
          },
          margins = dpi(4),
          widget = wibox.container.margin,
        },
        id = "icon_bg",
        bg = beautiful.cc_button_clear_all_notif_bg
          or beautiful.cc_button_urgent_bg
          or beautiful.cc_button_urgent_default_bg,
        shape = gears.shape.circle,
        widget = wibox.container.background,
      },
      widget = clickable_container,
    },
    top = dpi(25),
    widget = wibox.container.margin,
    layout = wibox.layout.align.horizontal,
  },
  notifbox_layout,
  spacing = dpi(15),
  layout = wibox.layout.fixed.vertical,
})

notif_center
  :get_children_by_id("icon_bg")[1]
  :connect_signal("button::press", function(_)
    notifbox_layout:reset(notifbox_layout)
    notifbox_layout:insert(1, empty_notifbox)
  end)

scroller(notifbox_layout)

naughty.connect_signal("added", function(notif)
  if notif.app_icon == nil or not file_exists(notif.app_icon) then
    notif.app_icon = beautiful.cc_notif_empty_icon
      or script_path() .. "icons/notifications.svg"
  end

  if notif.urgency == "critical" then
    notif.fg = beautiful.cc_notif_critical_fg
      or beautiful.cc_notif_critical_default_fg
    notif.bg = beautiful.cc_notif_critical_bg
      or beautiful.cc_notif_critical_default_bg
    notif.border_color = beautiful.cc_notif_critical_bg
      or beautiful.cc_notif_critical_default_bg
  else
    notif.fg = beautiful.cc_notif_normal_fg
      or beautiful.cc_notif_normal_default_fg
    notif.bg = beautiful.cc_notif_normal_bg
      or beautiful.cc_notif_normal_default_bg
    notif.border_color = beautiful.cc_notif_normal_bg
      or beautiful.cc_notif_normal_default_bg
  end

  notif.shape = beautiful.cc_notif_shape or gears.shape.rounded_rect
  notif.max_width = beautiful.cc_notif_max_width or dpi(250)
  -- notif.image = gears.surface.load_from_shape(dpi(32), dpi(32), notif.image)

  notifbox_layout:insert(1, create_notifbox(notif))
end)

return notif_center
