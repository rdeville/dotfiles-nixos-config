---@diagnostic disable undefined-global
local gears = require("gears")
local beautiful = require("beautiful")

screen.connect_signal(
  "property::geometry",
  -- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
  function(s)
    -- Wallpaper
    if beautiful.wallpaper then
      local wallpaper = beautiful.wallpaper
      -- If wallpaper is a function, call it with the screen
      if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
      end
      gears.wallpaper.maximized(wallpaper, s, true)
    end
  end
)
