local awful = require("awful")

-- Round function for display
local function round(num)
  local under = math.floor(num)
  local upper = math.floor(num) + 1
  local underV = -(under - num)
  local upperV = upper - num
  if upperV > underV then
    return under
  else
    return upper
  end
end

---@diagnostic disable-next-line:lowercase-global
function script_path()
  local str = debug.getinfo(2, "S").source:sub(2)
  return str:match("(.*/)")
end

---@diagnostic disable-next-line:lowercase-global
function scandir(directory)
  local i, t, popen = 0, {}, io.popen
  local pfile = popen("ls '" .. directory .. "'")
  if pfile == nil then
    return
  end
  for filename in pfile:lines() do
    i = i + 1
    t[i] = filename
  end
  pfile:close()
  return t
end

---@diagnostic disable-next-line:lowercase-global
function run_once(cmd_arr)
  local findme
  local firstspace
  for _, cmd in ipairs(cmd_arr) do
    findme = cmd
    firstspace = cmd:find(" ")
    if firstspace then
      findme = cmd:sub(0, firstspace - 1)
    end
    awful.spawn.with_shell(
      string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, cmd)
    )
  end
end

---@diagnostic disable-next-line:lowercase-global
function sum_array(array, start_idx, end_idx)
  local sum = 0
  for idx = start_idx, end_idx do
    sum = sum + tonumber(array[idx])
  end
  return sum
end

---@diagnostic disable-next-line:lowercase-global
function gradient(min, max, val)
  local v, d, red, green
  if min >= max then
    if val > min then
      val = min
    end
    if val < max then
      val = max
    end

    v = val - max
    d = (min - max) * 0.5

    if v <= d then
      red = 255
      green = round((255 * v) / d)
    else
      red = round(255 - (255 * (v - d)) / (min - max - d))
      green = 255
    end
  else
    if val > max then
      val = max
    end
    if val < min then
      val = min
    end

    v = val - min
    d = (max - min) * 0.5

    if v <= d then
      red = round((255 * v) / d)
      green = 255
    else
      red = 255
      green = round(255 - (255 * (v - d)) / (max - min - d))
    end
  end

  return string.format("#%02x%02x00", red, green)
end

---@diagnostic disable-next-line:lowercase-global
function os.capture(cmd, raw)
  local f = assert(io.popen(cmd, "r"))
  local s = assert(f:read("*a"))
  f:close()
  if raw then
    return s
  end
  s = string.gsub(s, "^%s+", "")
  s = string.gsub(s, "%s+$", "")
  s = string.gsub(s, "[\n\r]+", "")
  return s
end

---@diagnostic disable-next-line:lowercase-global
function split(string_to_split, separator)
  if separator == nil then
    separator = "%s"
  end
  local t = {}

  for str in string.gmatch(string_to_split, "([^" .. separator .. "]+)") do
    table.insert(t, str)
  end

  return t
end

---@diagnostic disable-next-line:lowercase-global
function dump(o)
  if type(o) == "table" then
    local s = "{ "
    for k, v in pairs(o) do
      if type(k) ~= "number" then
        k = '"' .. k .. '"'
      elseif type(k) ~= "function" then
        s = s .. "[" .. k .. "] = " .. dump(v) .. ","
      end
    end
    return s .. "} "
  else
    return tostring(o)
  end
end

---@diagnostic disable-next-line:lowercase-global
function table_equals(obj1, obj2)
  if (obj1 == nil and obj2 ~= nil) or #obj1 ~= #obj2 then
    return false
  end
  for key, val in pairs(obj1) do
    if obj2[key] ~= nil or obj2[key] ~= val then
      return false
    end
  end
  return true
end

---@diagnostic disable-next-line:lowercase-global
function file_exists(name)
   local f = io.open(name, "r")
   return f ~= nil and io.close(f)
end
