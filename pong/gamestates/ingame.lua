local Camera = require 'pong.vendor.hump.camera'
local Signal = require 'pong.vendor.hump.signal'

local Goal = require 'pong.goal'
local KeyState = require 'pong.key_state'
local Scene = require 'pong.scene'
local Ball = require 'pong.entities.ball'
local Paddle = require 'pong.entities.paddle'
local destroy = require 'pong.systems.destroy'

local Ingame = {}

Ingame.BOUNCE_INTENSITY = 5
Ingame.CAMERA_INTENSITY_FALLOFF = 0.2
Ingame.CENTER_X = love.graphics.getWidth() / 2
Ingame.CENTER_Y = love.graphics.getHeight() / 2

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
local function make_paddles(scene)
  Paddle.init()

  local paddle_y = love.graphics.getHeight() / 2 - Paddle.HEIGHT / 2
  local right_paddle_x = love.graphics.getWidth() - Paddle.WIDTH
  return Paddle(0, paddle_y, 'left_player_up', 'left_player_down', scene),
         Paddle(right_paddle_x, paddle_y, 'right_player_up', 'right_player_down', scene)
end

function Ingame:handle_bounce()
  self.camera_intensity = self.camera_intensity + Ingame.BOUNCE_INTENSITY
end

function Ingame:init()
  self.camera = Camera(Ingame.CENTER_X, CENTER_Y)
  self.camera_intensity = 0

  Signal.register('bounce', function() self:handle_bounce() end)

  local left_goal, right_goal = make_goals()
  scene:add_goal(left_goal)
  scene:add_goal(right_goal)

  local left_paddle, right_paddle = make_paddles(scene)
  table.insert(entities, left_paddle)
  table.insert(entities, right_paddle)
  scene:add_paddle(left_paddle)
  scene:add_paddle(right_paddle)

  local ball = Ball(scene)
  table.insert(entities, ball)
  scene:add_ball(ball)
end

function Ingame:update(dt)
  key_state:update()

  for i, entity in pairs(entities) do
    entity:update(dt, key_state)
  end

  -- Destroy in reverse for proper table cleanup.
  for i = #entities, 1, -1 do
    destroy(entities[i], entities, i)
  end
end

-- Update the position of the camera. This adds screen shaking.
function Ingame:update_camera()
  if self.camera_intensity > 0 then
    self.camera_intensity = math.max(0, self.camera_intensity - Ingame.CAMERA_INTENSITY_FALLOFF)
  end
  self.camera:lookAt(
    Ingame.CENTER_X + math.random(-self.camera_intensity, self.camera_intensity),
    Ingame.CENTER_Y + math.random(-self.camera_intensity, self.camera_intensity))
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
  self:update_camera()
  self.camera:draw(Ingame.draw_court)
end

return Ingame
