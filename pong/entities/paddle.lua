local anim8 = require 'pong.vendor.anim8.anim8'

local Constants = require 'pong.constants'
local Court = require 'pong.court'
local Utils = require 'pong.utils'

-- A paddle that a player controls
local Paddle = {}
Paddle.__index = Paddle

Paddle.HEIGHT = 128
Paddle.WIDTH = 16

Paddle.SPEED = 256

function Paddle.init()
  Paddle.image = love.graphics.newImage('assets/images/paddle.png')
  -- Avoid linear interpolation on the image to get the crisp pixels.
  Paddle.image:setFilter('nearest', 'nearest')
  Paddle.grid = anim8.newGrid(
    Paddle.WIDTH, Paddle.HEIGHT, Paddle.image:getWidth(), Paddle.image:getHeight())
end

local function construct(cls, x, y, up_key, down_key, scene)
  local self = setmetatable({}, Paddle)

  -- Use the upper left corner to easily draw a rectangle.
  self.x = x
  self.y = y

  -- Store the up/down direction that maps to a key state.
  self.up_key = up_key
  self.down_key = down_key

  self.scene = scene

  self.y_direction = Constants.UP

  self.animation = anim8.newAnimation(Paddle.grid('1-4', 1, '4-1', 1), 0.06, 'pauseAtEnd')
  self.animation:pauseAtStart()

  return self
end
setmetatable(Paddle, {__call = construct})

function Paddle:update(dt, key_state)
  if key_state[self.up_key] and not self:collide_top() then
    self.y_direction = Constants.UP
    self:move(dt)
  end
  if key_state[self.down_key] and not self:collide_bottom() then
    self.y_direction = Constants.DOWN
    self:move(dt)
  end

  if self:collide_balls() then
    self.animation:gotoFrame(1)
    self.animation:resume()
  end

  self.animation:update(dt)
end

-- Check if the paddle collides with a ball.
function Paddle:collide_balls()
  local bbox = self:get_bbox()
  for i, ball in pairs(self.scene.balls) do
    if Utils.is_collision(bbox, ball:get_bbox()) then
      return true
    end
  end

  return false
end

-- Check if the paddle is in contact with the top of the court.
function Paddle:collide_top()
  bbox = self:get_bbox()
  return bbox.y <= Court.TOP
end

-- Check if the paddle is in contact with the bottom of the court.
function Paddle:collide_bottom()
  bbox = self:get_bbox()
  return bbox.y + bbox.h >= Court.BOTTOM
end

-- Get the bounding box.
function Paddle:get_bbox()
  return {
    x = self.x,
    y = self.y,
    h = Paddle.HEIGHT,
    w = Paddle.WIDTH,
  }
end

-- Change the paddle's vertical position.
function Paddle:move(dt)
  self.y = self.y + Paddle.SPEED * self.y_direction * dt
end

function Paddle:draw()
  self.animation:draw(Paddle.image, self.x, self.y)
end

return Paddle
