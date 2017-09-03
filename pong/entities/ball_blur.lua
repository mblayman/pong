-- The blur that trails behind the ball.
local BallBlur = {}
BallBlur.__index = BallBlur

BallBlur.INITIAL_OPACITY = 0.5

local function construct(cls, x, y, radius)
  local self = setmetatable({}, BallBlur)

  self.opacity = BallBlur.INITIAL_OPACITY

  self.x = x
  self.y = y
  self.radius = radius

  return self
end
setmetatable(BallBlur, {__call = construct})

function BallBlur:update(dt, key_state)
  -- self.state(self, dt, key_state)
end

function BallBlur:draw()
  love.graphics.circle('fill', self.x, self.y, self.radius)
end

return BallBlur
