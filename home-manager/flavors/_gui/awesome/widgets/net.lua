local awful = require("awful")
local beautiful = require("widgets.theme")
local colors = require("utils.colors")
local wibox = require("wibox")

local net = {}

local function factory(_)
  local options = {
    timeout = beautiful.net_timeout or 1,
    clr_0 = beautiful.cpu_clr_3 or beautiful.clr_0 or beautiful.default_clr_0,
    clr_1 = beautiful.cpu_clr_2 or beautiful.clr_1 or beautiful.default_clr_1,
    clr_2 = beautiful.cpu_clr_1 or beautiful.clr_2 or beautiful.default_clr_2,
    clr_3 = beautiful.cpu_clr_0 or beautiful.clr_3 or beautiful.default_clr_3,

    val_0 = beautiful.net_val_0 or 2.5 * 1024 * 1024,
    val_1 = beautiful.net_val_1 or 5 * 1024 * 1024,
    val_2 = beautiful.net_val_2 or 7.5 * 1024 * 1024,
    val_3 = beautiful.net_val_3 or 10 * 1024 * 1024,

    prev_rx = 0,
    prev_tx = 0,
  }
  local command = beautiful.net_command
    or (
      "cat /sys/class/net/"
      .. (beautiful.net_interface or "*")
      .. "/statistics/*_bytes"
    )

  local function compute_tier_clr(value)
    if value <= options.val_0 then
      return options.clr_0
    elseif value <= options.val_1 then
      return options.clr_1
    elseif value <= options.val_2 then
      return options.clr_2
    else
      return options.clr_3
    end
  end

  local function content(bytes, format)
    format = format or "%03.0f %s"
    local speed
    local dim
    if bytes < 1024 then
      speed = bytes
      dim = " b"
    elseif bytes < 1024 ^ 2 then
      speed = bytes / 1024
      dim = "Kb"
    elseif bytes < 1024 ^ 3 then
      speed = bytes / 1024 ^ 2
      dim = "Mb"
    elseif bytes < 1024 ^ 4 then
      speed = bytes / 1024 ^ 3
      dim = "Gb"
    end
    return string.format(format, math.floor(speed + 0.5), dim)
  end

  local function ping()
    local return_code = os.execute(
      "ping -c 1 -w "
        .. (beautiful.net_ping_timeout or 3)
        .. " "
        .. (beautiful.net_ping_route or "wikipedia.org")
    )
    if return_code == 0 then
      return true
    end
    return false
  end

  local update_widget = function(widget)
    local cur_vals = split(os.capture(command, true), "\r\n")
    local cur_rx = 0
    local cur_tx = 0
    local speed_rx = 0
    local speed_tx = 0
    local color = ""
    local text = ""

    for i, _ in ipairs(cur_vals) do
      if i % 2 == 1 then
        cur_rx = cur_rx + cur_vals[i]
      end
      if i % 2 == 0 then
        cur_tx = cur_tx + cur_vals[i]
      end
    end

    speed_rx = cur_rx - options.prev_rx
    speed_tx = cur_tx - options.prev_tx

    color = compute_tier_clr(speed_rx)
    text = content(speed_rx, "%05.1f%s")
    widget:get_children_by_id("down")[1].fg = color
    widget:get_children_by_id("down_value")[1].text =
      string.format("%s %s ", text, beautiful.net_down_icon or " ")

    color = compute_tier_clr(speed_tx)
    text = content(speed_tx, "%05.1f%s")
    widget:get_children_by_id("up")[1].fg = color
    widget:get_children_by_id("up_value")[1].text =
      string.format(" %s %s", beautiful.net_up_icon or " ", text)

    if ping then
      widget:get_children_by_id("online")[1].fg = (
        beautiful.net_online_fg or colors.green_500
      )
      widget:get_children_by_id("online_status")[1].text = (
        beautiful.net_online_icon or "󰲝 "
      )
    else
      widget:get_children_by_id("offline")[1].fg = (
        beautiful.net_offline_fg or colors.red_500
      )
      widget:get_children_by_id("offline_status")[1].text = (
        beautiful.net_offline_icon or "󰲜 "
      )
    end

    options.prev_rx = cur_rx
    options.prev_tx = cur_tx
  end

  net = wibox.widget({
    {
      {
        {
          {
            id = "down_value",
            align = "right",
            widget = wibox.widget.textbox,
          },
          id = "down",
          widget = wibox.container.background,
        },
        {
          {
            id = "online_status",
            widget = wibox.widget.textbox,
          },
          id = "online",
          widget = wibox.container.background,
        },
        {
          {
            id = "up_value",
            align = "left",
            widget = wibox.widget.textbox,
          },
          id = "up",
          widget = wibox.container.background,
        },
        layout = wibox.layout.align.horizontal,
      },
      widget = wibox.container.margin(nil, 15, 15, 0, 0),
    },
    bg = beautiful.net_bg or beautiful.widget_default_bg,
    font = beautiful.net_font or beautiful.font,
    shape = beautiful.net_shape or beautiful.widget_default_shape_right,
    widget = wibox.container.background,
  })

  awful.widget.watch("echo &>/dev/null", options.timeout, update_widget, net)

  return net
end

return setmetatable(net, {
  __call = function(_, ...)
    return factory(...)
  end,
})
