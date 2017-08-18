local Constants = require 'pong.constants'

-- The ball that bounces back and forth.
local Ball = {}
Ball.__index = Ball

-- States
Ball.READY_STATE = 1
Ball.MOVING_STATE = 2

local RADIUS = 32
local SPEED = 128

-- Use a set of angles to keep the game interesting.
-- No one wants to play pong when the angle is 89 degrees.
-- The trig functions expect radian so use ratios of the unit circle.
local ANGLES = {
  1 / 12, -- 15
  1 / 6, -- 30
  1 / 4, -- 45
  1 / 3, -- 60
}

local function construct()
  local self = setmetatable({}, Ball)

  self.state = Ball.READY_STATE

  -- Start the ball in the middle of the court.
  self.x = love.graphics.getWidth() / 2
  self.y = love.graphics.getHeight() / 2

  self.x_direction = Constants.RIGHT
  self.x_speed = 0
  self.y_direction = Constants.DOWN
  self.y_speed = 0

  return self
end
setmetatable(Ball, {__call = construct})

function Ball:update(dt, key_state)
  if self.state == Ball.READY_STATE then
    if key_state['start'] then
      self.state = Ball.MOVING_STATE
      self.x_direction = Constants.X_DIRECTIONS[math.random(#Constants.X_DIRECTIONS)]
      self:set_speeds()
    end

  elseif self.state == Ball.MOVING_STATE then
    self.x = self.x + self.x_speed * self.x_direction * dt
    self.y = self.y + self.y_speed * self.y_direction * dt

  end
end

-- Set x and y speeds to produce a given angle for the ball.
function Ball:set_speeds()
  local angle = ANGLES[math.random(#ANGLES)]
  self.x_speed = SPEED * math.cos(math.pi * angle)
  self.y_speed = SPEED * math.sin(math.pi * angle)
end

function Ball:draw()
  love.graphics.circle('fill', self.x, self.y, RADIUS)
end

return Ball