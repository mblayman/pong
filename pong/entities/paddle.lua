-- A paddle that a player controls
local Paddle = {}
Paddle.__index = Paddle

Paddle.HEIGHT = 128
Paddle.WIDTH = 16

local function construct(cls, x, y)
  local self = setmetatable({}, Paddle)

  -- Use the upper left corner to easily draw a rectangle.
  self.x = x
  self.y = y

  return self
end
setmetatable(Paddle, {__call = construct})

function Paddle:update(dt, key_state)
end

function Paddle:draw()
  love.graphics.rectangle('fill', self.x, self.y, Paddle.WIDTH, Paddle.HEIGHT)
end

return Paddle
