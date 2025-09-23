---@diagnostic disable undefined-global
local awful = require("awful")

tag.connect_signal(
  "property::layout",
  -- Apply floatin property to all client when switching to floating layout
  function(tag)
    if tag.layout == awful.layout.suit.floating then
      for _, c in ipairs(tag:clients()) do
        if not c.floating then
          c.floating = true
        end
      end
    else
      for _, c in ipairs(tag:clients()) do
        if c.floating then
          c.floating = false
        end
      end
    end
  end
)
