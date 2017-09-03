local destroy = require 'pong.systems.destroy'

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

-- Update the entities and run systems.
function Scene:update(dt, key_state)
  for i, entity in ipairs(self.entities) do
    entity:update(dt, key_state)
  end

  -- Destroy in reverse for proper table cleanup.
  for i = #self.entities, 1, -1 do
    destroy(self.entities[i], self.entities, i)
  end
end

function Scene:draw()
  for i, entity in ipairs(self.entities) do
    entity:draw()
  end
end

return Scene
