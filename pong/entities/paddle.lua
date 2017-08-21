local Constants = require 'pong.constants'
local Court = require 'pong.court'

-- A paddle that a player controls
local Paddle = {}
Paddle.__index = Paddle

Paddle.HEIGHT = 128
Paddle.WIDTH = 16

Paddle.SPEED = 256

local function construct(cls, x, y, up_key, down_key)
  local self = setmetatable({}, Paddle)

  -- Use the upper left corner to easily draw a rectangle.
  self.x = x
  self.y = y

  -- Store the up/down direction that maps to a key state.
  self.up_key = up_key
  self.down_key = down_key

  self.y_direction = Constants.UP

  return self
end
setmetatable(Paddle, {__call = construct})

function Paddle:update(dt, key_state)
  if key_state[self.up_key] and not self:collide_top() then
    self.y_direction = Constants.UP
    self:move(dt)
  elseif key_state[self.down_key] and not self:collide_bottom() then
    self.y_direction = Constants.DOWN
    self:move(dt)
  end
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

-- Get the boundary box.
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
  love.graphics.rectangle('fill', self.x, self.y, Paddle.WIDTH, Paddle.HEIGHT)
end

return Paddle
