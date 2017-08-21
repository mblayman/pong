local Constants = require 'pong.constants'

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
  if key_state[self.up_key] then
    self.y_direction = Constants.UP
    self:move(dt)
  elseif key_state[self.down_key] then
    self.y_direction = Constants.DOWN
    self:move(dt)
  end
end

-- Change the paddle's vertical position.
function Paddle:move(dt)
  self.y = self.y + Paddle.SPEED * self.y_direction * dt
end

function Paddle:draw()
  love.graphics.rectangle('fill', self.x, self.y, Paddle.WIDTH, Paddle.HEIGHT)
end

return Paddle
