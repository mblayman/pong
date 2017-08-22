local Scene = {}
Scene.__index = Scene

local function construct()
  local self = setmetatable({}, Scene)

  self.goals = {}
  self.paddles = {}

  return self
end
setmetatable(Scene, {__call = construct})

function Scene:add_goal(goal)
  table.insert(self.goals, goal)
end

function Scene:add_paddle(paddle)
  table.insert(self.paddles, paddle)
end

return Scene
