local Goal = {}
Goal.__index = Goal

Goal.WIDTH = 16

local function construct(cls, x, y, height)
  local self = setmetatable({}, Goal)

  self.x = x
  self.y = y

  self.height = height

  return self
end
setmetatable(Goal, {__call = construct})

-- Get the bounding box.
function Goal:get_bbox()
  return {
    x = self.x,
    y = self.y,
    h = self.height,
    w = Goal.WIDTH,
  }
end
return Goal
