-- The ball that bounces back and forth.
local Ball = {}
Ball.__index = Ball

-- States
Ball.READY_STATE = 1

local RADIUS = 32

local function construct()
  local self = setmetatable({}, Ball)

  self.state = Ball.READY_STATE

  -- Start the ball in the middle of the court.
  self.x = love.graphics.getWidth() / 2
  self.y = love.graphics.getHeight() / 2

  return self
end
setmetatable(Ball, {__call = construct})

function Ball:update(dt, key_state)
end

function Ball:draw()
  love.graphics.circle('fill', self.x, self.y, RADIUS)
end

return Ball
