-- From:
-- https://raw.githubusercontent.com/psliwka/my-awesome-config/master/rofi/init.lua

local awful = require("awful")

local rofi = {}

function rofi.stringified_parameter(key, value)
  if value == true then
    return "-" .. key
  elseif value == false then
    return "-no-" .. key
  else
    return "-" .. key .. " '" .. value .. "'"
  end
end

function rofi.stringified_parameters(parameters)
  local tmp = ""
  for key, value in pairs(parameters) do
    tmp = tmp .. " " .. rofi.stringified_parameter(key, value)
  end
  return tmp
end

function rofi.invocation(parameters)
  return "rofi" .. rofi.stringified_parameters(parameters)
end

function rofi.spawn(parameters)
  awful.spawn(rofi.invocation(parameters))
end

function rofi.prompt(args, callback)
  args = args or {}
  args.show = args.show or ""
  local function rofi_finished(stdout, _, _, exit_code)
    if exit_code ~= 0 then
      return
    end
    local entered_name = stdout:gsub("\n", "")
    if #entered_name ~= 0 then
      callback(entered_name)
    end
  end
  if callback then
    awful.spawn.easy_async(rofi.invocation(args), rofi_finished)
  else
    rofi.spawn(args)
  end
end

return rofi
