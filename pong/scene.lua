local Scene = {}
Scene.__index = Scene

local function construct()
  local self = setmetatable({}, Scene)

  self.balls = {}
  self.goals = {}
  self.paddles = {}

  return self
end
setmetatable(Scene, {__call = construct})

function Scene:add_ball(ball)
  table.insert(self.balls, ball)
end

function Scene:add_goal(goal)
  table.insert(self.goals, goal)
end

function Scene:add_paddle(paddle)
  table.insert(self.paddles, paddle)
end

-- TODO: add_entity
-- TODO: BallBlur
-- TODO: unit test destroy system.

return Scene
