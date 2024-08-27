local function get_rgb(color)
  return {
    tonumber(color:sub(2,3), 16), -- red
    tonumber(color:sub(4,5), 16), -- green
    tonumber(color:sub(6,7), 16), -- blue
  }
end

local function blend_colors(top, bottom, alpha)
  local top_rgb = get_rgb(top)
  local bottom_rgb = get_rgb(bottom)
  local blend = function(c)
    c = ((alpha * top_rgb[c]) + ((1 - alpha) * bottom_rgb[c]))
    return math.floor((math.min(math.max(0, c), 255) + 0.5))
  end
  return string.format("#%02X%02X%02X", blend(1), blend(2), blend(3))
end

return { blend_colors = blend_colors }
