local gears = require("gears")

---@diagnostic disable-next-line lowercase-global
local function merge_config(src, update)
  if update == nil then
    return src
  end
  for key, val in pairs(update) do
    src[key] = val
  end
  return src
end

local function hostname()
  local f = io.popen("hostname")
  if f ~= nil then
    local content = f:read("*a") or ""
    f:close()
    return string.gsub(content, "\n$", "")
  end
end

return {
  merge_config = merge_config,
  hostname = hostname,
}
