local Ball = require 'entities.ball'

local entities = {}

function love.load()
  entities.ball = Ball()
end

-- Update the state of the world.
function love.update(dt)
  for i, entity in pairs(entities) do
    entity:update(dt)
  end
end

-- Draw ALL THE THINGS!
function love.draw()
  -- Draw the background.
  local mid_x = love.graphics.getWidth() / 2
  love.graphics.line(mid_x, 0, mid_x, love.graphics.getHeight())

  for i, entity in pairs(entities) do
    entity:draw()
  end
end
