-- A paddle that a player controls
local Paddle = {}
Paddle.__index = Paddle

Paddle.HEIGHT = 128
Paddle.WIDTH = 16

local function construct(cls, x, y, up_key, down_key)
  local self = setmetatable({}, Paddle)

  -- Use the upper left corner to easily draw a rectangle.
  self.x = x
  self.y = y

  -- Store the up/down direction that maps to a key state.
  self.up_key = up_key
  self.down_key = down_key

  return self
end
setmetatable(Paddle, {__call = construct})

function Paddle:update(dt, key_state)
end

function Paddle:draw()
  love.graphics.rectangle('fill', self.x, self.y, Paddle.WIDTH, Paddle.HEIGHT)
end

return Paddle
