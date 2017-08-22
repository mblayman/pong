local Ball = require 'pong.entities.ball'
local Paddle = require 'pong.entities.paddle'
local KeyState = require 'pong.key_state'
local Scene = require 'pong.scene'

local entities = {}
local key_state = KeyState()
local scene = Scene()

-- Lua's random number generator doesn't have enough entropy to start.
-- Without some initial calls, the first random is always the same.
local function init_random()
  math.randomseed(os.time())
  math.random()
  math.random()
  math.random()
end

-- Make the left and right paddles.
local function make_paddles()
  local paddle_y = love.graphics.getHeight() / 2 - Paddle.HEIGHT / 2
  local right_paddle_x = love.graphics.getWidth() - Paddle.WIDTH
  return Paddle(0, paddle_y, 'left_player_up', 'left_player_down'),
         Paddle(right_paddle_x, paddle_y, 'right_player_up', 'right_player_down')
end

function love.load()
  init_random()

  entities.left_paddle, entities.right_paddle = make_paddles()
  scene:add_paddle(entities.left_paddle)
  scene:add_paddle(entities.right_paddle)

  entities.ball = Ball(scene)
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
