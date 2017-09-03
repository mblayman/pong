-- The blur that trails behind the ball.
local BallBlur = {}
BallBlur.__index = BallBlur

BallBlur.INITIAL_OPACITY = 130
BallBlur.OPACITY_FADE = 6

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
  local next_opacity = self.opacity - BallBlur.OPACITY_FADE
  if next_opacity > 0 then
    self.opacity = next_opacity
  else
    self.destroy = true
  end
end

function BallBlur:draw()
  love.graphics.setColor(255, 255, 255, self.opacity)
  love.graphics.circle('fill', self.x, self.y, self.radius)
  love.graphics.setColor(255, 255, 255, 255)
end

return BallBlur
