local awful = require("awful")
local beautiful = require("widgets.theme")
local naughty = require("naughty")
local wibox = require("wibox")

local bat = {}

local function factory(_)
  local power_info_dir = "/sys/class/power_supply/"
  local bat_info_dir = scandir(power_info_dir)

  if bat_info_dir ~= nil and #bat_info_dir > 0 then
    local found = false
    local idx = 1
    while not found do
      if string.find(bat_info_dir[idx], "BAT") then
        found = true
        bat_info_dir = bat_info_dir[idx]
      end
      idx = idx + 1
    end
    if not found then
      return nil
    end
  else
    return nil
  end

  local options = {
    timeout = beautiful.bat_timeout or 60,
    cmd_status = beautiful.bat_cmd_status
      or ("cat " .. power_info_dir .. bat_info_dir .. "/status"),
    cmd_capacity = beautiful.bat_cmd_capacity
      or ("cat " .. power_info_dir .. bat_info_dir .. "/capacity"),
    clr_0 = beautiful.bat_clr_0
      or beautiful.clr_0_inv
      or beautiful.default_clr_0_inv,
    clr_1 = beautiful.bat_clr_1
      or beautiful.clr_1_inv
      or beautiful.default_clr_1_inv,
    clr_2 = beautiful.bat_clr_2
      or beautiful.clr_2_inv
      or beautiful.default_clr_2_inv,
    clr_3 = beautiful.bat_clr_3
      or beautiful.clr_3_inv
      or beautiful.default_clr_3_inv,
    icon_charging_0 = beautiful.bat_icon_charging_0 or "󰂎󱐥",
    icon_charging_1 = beautiful.bat_icon_charging_1 or "󱊡󱐥",
    icon_charging_2 = beautiful.bat_icon_charging_2 or "󱊢󱐥",
    icon_charging_3 = beautiful.bat_icon_charging_3 or "󱊣󱐥",
    icon_discharging_0 = beautiful.bat_icon_discharging_0 or "󰂎 ",
    icon_discharging_1 = beautiful.bat_icon_discharging_1 or "󱊡 ",
    icon_discharging_2 = beautiful.bat_icon_discharging_2 or "󱊢 ",
    icon_discharging_3 = beautiful.bat_icon_discharging_3 or "󱊣 ",
    alert_value = beautiful.bat_alert_value or 10,
    alert_icon = beautiful.bat_alert_icon
      or script_path() .. "icons/dialog-warning.svg",
  }

  local update_widget = function(widget)
    local value = tonumber(os.capture(options.cmd_capacity))
    local clr_idx = math.floor(value / 25) == 4 and 3 or math.floor(value / 25)
    local status = os.capture(options.cmd_status)

    if status == "Discharging" and value <= options.alert_value then
      naughty.notify({
        icon = options.alert_icon,
        icon_size = beautiful.apply_dpi(34),
        title = "Battery Alert !",
        text = "Warning, Battery below " .. options.alert_value .. "% !",
        urgency = "critical",
      })
    end

    widget.fg = options["clr_" .. clr_idx]
    widget:get_children_by_id("bat_icon")[1].text =
      options["icon_" .. string.lower(status) .. "_" .. clr_idx]
    widget:get_children_by_id("bat_value")[1].text =
      string.format(" %03.1f%%", value)
  end

  bat = wibox.widget({
    {
      {
        {
          id = "bat_icon",
          widget = wibox.widget.textbox,
        },
        {
          id = "bat_value",
          widget = wibox.widget.textbox,
        },
        layout = wibox.layout.fixed.horizontal,
      },
      widget = wibox.container.margin(nil, 15, 15, 0, 0),
    },
    font = beautiful.bat_font or beautiful.font,
    bg = beautiful.bat_bg or beautiful.widget_default_bg,
    shape = beautiful.bat_shape or beautiful.widget_default_shape_right,
    widget = wibox.container.background,
  })

  awful.widget.watch("echo &>/dev/null", options.timeout, update_widget, bat)

  return bat
end

return setmetatable(bat, {
  __call = function(_, ...)
    return factory(...)
  end,
})
