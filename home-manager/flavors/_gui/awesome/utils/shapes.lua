local gears = require("gears")

local powerline_inv = function(cr, width, height)
  gears.shape.powerline(cr, width, height, -height / 2)
end

local rectangular_tag_inv = function(cr, width, height)
  gears.shape
    .transform(gears.shape.rectangular_tag)
    :rotate_at(width / 2, height / 2, math.pi)(cr, width, height)
end

local rounded_rect = function(cr, width, height)
  gears.shape.rounded_rect(cr, width, height, 10)
end

return {
  powerline = gears.shape.powerline,
  powerline_inv = powerline_inv,
  rectangular_tag = gears.shape.rectangular_tag,
  rectangular_tag_inv = rectangular_tag_inv,
  rounded_rect = rounded_rect,
}
