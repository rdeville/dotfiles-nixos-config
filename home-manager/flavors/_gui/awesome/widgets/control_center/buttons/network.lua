local awful = require("awful")
local beautiful = require("widgets.theme")
local create_button = require("widgets.control_center.buttons.create-button")
local gears = require("gears")
local naughty = require("naughty")

-- Network button for control center
local network_button = create_button.circle_big(
  beautiful.cc_button_network_icon
    or script_path() .. "../icons/network-lan-down.svg"
)

network_button.last_state = {}

local function get_interface_state(interface)
  return os.capture("cat /sys/class/net/" .. interface .. "/operstate")
end

local function get_interfaces(regexp)
  local interfaces = {}
  for match in os.capture("ls /sys/class/net/", true):gmatch(regexp) do
    table.insert(interfaces, { name = match:gsub("\n", "") })
  end
  return interfaces
end

local net = {
  foo = "bar",
  lan = {
    interfaces = beautiful.cc_network_wifi_interfaces
      or get_interfaces("(e[a-zA-Z0-9]*)"),
    up = {
      icon = beautiful.cc_button_network_lan_up_icon
        or script_path() .. "../icons/network-lan-up.svg",
      bg = beautiful.cc_button_network_lan_up_bg
        or beautiful.cc_button_active_bg
        or beautiful.cc_button_active_default_bg,
    },
    down = {
      icon = beautiful.cc_button_network_lan_down_icon
        or script_path() .. "../icons/network-lan-down.svg",
      bg = beautiful.cc_button_network_lan_down_bg
        or beautiful.cc_button_inactive_bg
        or beautiful.cc_button_inactive_default_bg,
    },
    connected = {
      icon = beautiful.cc_button_network_lan_connected_icon
        or script_path() .. "../icons/network-lan-up.svg",
      bg = beautiful.cc_button_network_lan_connected_bg
        or beautiful.cc_button_connected_bg
        or beautiful.cc_button_connected_default_bg,
    },
  },
  wifi = {
    interfaces = beautiful.cc_network_wifi_interfaces
      or get_interfaces("(wl.*)"),
    up = {
      icon = beautiful.cc_button_network_wifi_up_icon
        or script_path() .. "../icons/network-wifi-up.svg",
      bg = beautiful.cc_button_network_wifi_up_bg
        or beautiful.cc_button_active_bg
        or beautiful.cc_button_active_default_bg,
    },
    down = {
      icon = beautiful.cc_button_network_lan_down_icon
        or script_path() .. "../icons/network-wifi-down.svg",
      bg = beautiful.cc_button_network_wifi_down_bg
        or beautiful.cc_button_inactive_bg
        or beautiful.cc_button_inactive_default_bg,
    },
    connected = {
      icon = beautiful.cc_button_network_wifi_connected_icon
        or script_path() .. "../icons/network-wifi-up.svg",
      bg = beautiful.cc_button_network_wifi_connected_bg
        or beautiful.cc_button_connected_bg
        or beautiful.cc_button_connected_default_bg,
    },
  },
}

local function set_status()
  local background = network_button:get_children_by_id("background")[1]
  local label = network_button:get_children_by_id("label")[1]
  local icon = network_button:get_children_by_id("icon")[1]
  local wlan_state = "Down"
  local curr_state = {}

  -- Create wireless connection notification
  local function notify_wireless_connected(essid)
    naughty.notify({
      title = "Connection Established",
      message = "Wireless connected to <b>" .. essid .. "</b>",
      app_name = "System Notification",
      icon = net.wifi.up.icon,
    })
  end
  -- Create wired connection notification
  local function notify_wired_connected(lan)
    naughty.notify({
      title = "Connection Established",
      message = 'Ethernet connected with <b>"' .. lan .. '"</b>',
      app_name = "System Notification",
      notif_icon = net.lan.up.icon,
    })
  end
  local function notify_wireless_disconnected()
    naughty.notify({
      title = "Connection Disconnected",
      message = "Wi-Fi network has been disconnected",
      app_name = "System Notification",
      notif_icon = net.wifi.down.icon,
    })
  end
  local function notify_wired_disconnected()
    naughty.notify({
      title = "Connection Disconnected",
      message = "Ethernet network has been disconnected",
      app_name = "System Notification",
      notif_icon = net.lan.down.icon,
    })
  end

  local state = nil
  -- If ethernet interface exists, check if connected. If so, deactivate
  -- wireless.
  for _, value in ipairs(net.lan.interfaces) do
    state = get_interface_state(value.name)
    if
      state == "up"
      and os.capture("ip addr show " .. value.name, true)
        :match("(inet.*brd)")
        :match(
          "([0-9]?[0-9]?[0-9]?%.[0-9][0-9]?[0-9]?%.[0-9][0-9]?[0-9]?%.[0-9][0-9]?[0-9]?)"
        )
    then
      label.text = "Connected"
      background.bg = net.lan.connected.bg
      icon.image = net.lan.connected.icon
      awful.spawn.with_shell("rfkill block wlan")
    end
  end

  if state == nil or state ~= "up" then
    state = os.capture("rfkill list wlan")
    if state:match("Soft blocked: yes") or state:match("Hard blocked: yes") then
      awful.spawn.with_shell("rfkill unblock wlan")
    end
    -- Update wireless interfaces and set buttons if one of the interfaces
    -- is connected
    for _, value in ipairs(net.wifi.interfaces) do
      state = get_interface_state(value.name)
      if os.capture("rfkill list wlan"):match("Soft blocked: no") then
        value.state = "up"
        if state == "up" then
          local essid = os.capture("iw dev " .. value.name .. " link", true)
            :match("SSID: ([a-zA-z0-9-_]*)\n") or "N/A"
          wlan_state = "Up"

          if essid ~= "N/A" then
            label.text = essid
            background.bg = net.wifi.connected.bg
            icon.image = net.wifi.connected.icon

            curr_state = {
              state = "connected",
              interface = value.name,
              type = "wireless",
            }
            if not table_equals(network_button.last_state, curr_state) then
              network_button.last_state = curr_state
              notify_wireless_connected(essid)
            end
            return
          end
        else
          value.state = "down"
        end
      end
      -- Default button configuration
      label.text = wlan_state
      background.bg = net.wifi[string.lower(wlan_state)].bg
      icon.image = net.wifi[string.lower(wlan_state)].icon
      curr_state = {
        state = "wlan_state",
        interface = "any",
        type = "wireless",
      }
    end
  end

  if not table_equals(network_button.last_state, curr_state) then
    if curr_state.type == network_button.last_state.type == "wireless" then
      notify_wireless_disconnected()
    end
    if
      curr_state.type ~= network_button.last_state.type
      and network_button.last_state == "wireless"
      and curr_state.state == "connected"
    then
      notify_wired_connected(curr_state.interface)
    end
    network_button.last_state = curr_state
  end
end

gears.timer({
  timeout = 5,
  autostart = true,
  call_now = true,
  callback = function()
    set_status()
  end,
})

network_button:connect_signal("button::press", function(self)
  awful.spawn.easy_async_with_shell("rfkill list wifi", function(stdout)
    if stdout:match("Soft blocked: yes") then
      awful.spawn.with_shell("rfkill unblock wifi")
      self:get_children_by_id("icon")[1].text = "Go on..."
    else
      awful.spawn.with_shell("rfkill block wifi")
      self:get_children_by_id("icon")[1].text = "Go off..."
    end
  end)
end)

set_status()

return network_button
