local Camera = require 'pong.vendor.hump.camera'

local Ingame = {}

local Goal = require 'pong.goal'
local KeyState = require 'pong.key_state'
local Scene = require 'pong.scene'
local Ball = require 'pong.entities.ball'
local Paddle = require 'pong.entities.paddle'

local camera = Camera(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
local entities = {}
local key_state = KeyState()
local scene = Scene()

-- Make the left and right goals.
local function make_goals()
  local height = love.graphics.getHeight()
  local right_goal_x = love.graphics.getWidth() - Goal.WIDTH
  return Goal(0, 0, height), Goal(right_goal_x, 0, height)
end

-- Make the left and right paddles.
local function make_paddles()
  local paddle_y = love.graphics.getHeight() / 2 - Paddle.HEIGHT / 2
  local right_paddle_x = love.graphics.getWidth() - Paddle.WIDTH
  return Paddle(0, paddle_y, 'left_player_up', 'left_player_down'),
         Paddle(right_paddle_x, paddle_y, 'right_player_up', 'right_player_down')
end

function Ingame:init()
  local left_goal, right_goal = make_goals()
  scene:add_goal(left_goal)
  scene:add_goal(right_goal)

  entities.left_paddle, entities.right_paddle = make_paddles()
  scene:add_paddle(entities.left_paddle)
  scene:add_paddle(entities.right_paddle)

  entities.ball = Ball(scene)
end

function Ingame:update(dt)
  key_state:update()

  for i, entity in pairs(entities) do
    entity:update(dt, key_state)
  end
end

function Ingame:draw_court()
  -- Draw the background.
  local mid_x = love.graphics.getWidth() / 2
  love.graphics.line(mid_x, 0, mid_x, love.graphics.getHeight())

  -- Draw the moving stuff.
  for i, entity in pairs(entities) do
    entity:draw()
  end
end

function Ingame:draw()
  camera:draw(Ingame.draw_court)
end

return Ingame
