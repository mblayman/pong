local Scene = {}
Scene.__index = Scene

local function construct()
  local self = setmetatable({}, Scene)

  self.balls = {}
  self.entities = {}
  self.goals = {}
  self.paddles = {}

  return self
end
setmetatable(Scene, {__call = construct})

function Scene:add_entity(entity)
  table.insert(self.entities, entity)
end

function Scene:add_ball(ball)
  table.insert(self.balls, ball)
  self:add_entity(ball)
end

function Scene:add_goal(goal)
  table.insert(self.goals, goal)
end

function Scene:add_paddle(paddle)
  table.insert(self.paddles, paddle)
  self:add_entity(paddle)
end

-- TODO: BallBlur

return Scene
