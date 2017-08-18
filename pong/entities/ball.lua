local Constants = require 'pong.constants'

-- The ball that bounces back and forth.
local Ball = {}
Ball.__index = Ball

-- States
Ball.READY_STATE = 1
Ball.MOVING_STATE = 2

local RADIUS = 32
local X_SPEED = 128

local function construct()
  local self = setmetatable({}, Ball)

  self.state = Ball.READY_STATE

  -- Start the ball in the middle of the court.
  self.x = love.graphics.getWidth() / 2
  self.y = love.graphics.getHeight() / 2

  self.x_direction = Constants.RIGHT

  return self
end
setmetatable(Ball, {__call = construct})

function Ball:update(dt, key_state)
  if self.state == Ball.READY_STATE then
    if key_state['start'] then
      self.state = Ball.MOVING_STATE
      self.x_direction = Constants.X_DIRECTIONS[math.random(#Constants.X_DIRECTIONS)]
    end

  elseif self.state == Ball.MOVING_STATE then
    self.x = self.x + X_SPEED * self.x_direction * dt

  end
end

function Ball:draw()
  love.graphics.circle('fill', self.x, self.y, RADIUS)
end

return Ball
