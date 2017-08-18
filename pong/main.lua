local Ball = require 'pong.entities.ball'
local KeyState = require 'pong.key_state'

local entities = {}
local key_state = KeyState()

-- Lua's random number generator doesn't have enough entropy to start.
-- Without some initial calls, the first random is always the same.
local function initRandom()
  math.randomseed(os.time())
  math.random()
  math.random()
  math.random()
end

function love.load()
  initRandom()
  entities.ball = Ball()
end

-- Update the state of the world.
function love.update(dt)
  key_state:update()

  for i, entity in pairs(entities) do
    entity:update(dt, key_state)
  end
end

-- Draw ALL THE THINGS!
function love.draw()
  -- Draw the background.
  local mid_x = love.graphics.getWidth() / 2
  love.graphics.line(mid_x, 0, mid_x, love.graphics.getHeight())

  -- Draw the moving stuff.
  for i, entity in pairs(entities) do
    entity:draw()
  end
end
