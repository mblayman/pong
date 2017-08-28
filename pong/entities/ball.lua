local Signal = require 'pong.vendor.hump.signal'
local Timer = require 'pong.vendor.hump.timer'

local Constants = require 'pong.constants'
local Court = require 'pong.court'

-- The ball that bounces back and forth.
local Ball = {}
Ball.__index = Ball

-- States
Ball.READY_STATE = 1
Ball.MOVING_STATE = 2
Ball.SCORING_STATE = 3

Ball.RADIUS = 16
Ball.DIAMETER = Ball.RADIUS * 2 -- For bounding box calculation
Ball.BOUNCE_COOLDOWN = 5
local SPEED = 256

-- Use a set of angles to keep the game interesting.
-- No one wants to play pong when the angle is 89 degrees.
-- The trig functions expect radian so use ratios of the unit circle.
local ANGLES = {
  1 / 12, -- 15
  1 / 6, -- 30
  1 / 4, -- 45
  1 / 3, -- 60
}

local function construct(cls, scene)
  local self = setmetatable({}, Ball)

  self.scene = scene

  self.state = Ball.READY_STATE

  -- Start the ball in the middle of the court.
  self.x = love.graphics.getWidth() / 2
  self.y = love.graphics.getHeight() / 2

  self.x_direction = Constants.RIGHT
  self.x_speed = 0
  self.y_direction = Constants.DOWN
  self.y_speed = 0

  -- Extra state is needed for a bounce cooldown.
  -- When the ball collides with a wall, the direction is flipped.
  -- Without any buffer, two collisions can occur back to back.
  -- This leads to a cycle where the ball starts toggling back
  -- and forth in direction and gets "stuck."
  self.just_x_bounced = false
  self.just_y_bounced = false

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
    self:update_collide_x(dt)
    self:update_collide_y(dt)

    self.x = self.x + self.x_speed * self.x_direction * dt
    self.y = self.y + self.y_speed * self.y_direction * dt

  elseif self.state == Ball.SCORING_STATE then
    self:update_collide_y(dt)

    self.x = self.x + self.x_speed * self.x_direction * dt
    self.y = self.y + self.y_speed * self.y_direction * dt

  end
end

-- Check if the ball collides with a paddle.
function Ball:collide_paddles()
  for i, paddle in pairs(self.scene.paddles) do
    if self:collide_box(paddle:get_bbox()) then
      return true
    end
  end

  return false
end

-- Check if the ball collides with a goal.
function Ball:collide_goals()
  for i, goal in pairs(self.scene.goals) do
    if self:collide_box(goal:get_bbox()) then
      return true
    end
  end

  return false
end

-- Update if the ball collides with the paddles or goals.
function Ball:update_collide_x(dt)
  if self.just_x_bounced then
    return
  end

  self.just_x_bounced = self:collide_paddles()

  if self.just_x_bounced then
    self.x_direction = self.x_direction * Constants.REVERSE
    Signal.emit('bounce')
    Timer.after(Ball.BOUNCE_COOLDOWN * dt, function() self.just_x_bounced = false end)
  elseif self:collide_goals() then
    self.state = Ball.SCORING_STATE
  end
end

-- Update if the ball collides with the top or bottom.
function Ball:update_collide_y(dt)
  if self.just_y_bounced then
    return
  end

  local bbox = self:get_bbox()

  self.just_y_bounced = bbox.y <= Court.TOP or bbox.y + bbox.h >= Court.BOTTOM

  if self.just_y_bounced then
    self.y_direction = self.y_direction * Constants.REVERSE
    Signal.emit('bounce')
    Timer.after(Ball.BOUNCE_COOLDOWN * dt, function() self.just_y_bounced = false end)
  end

end

-- Check if the ball collided with another bounding box.
function Ball:collide_box(other_bbox)
  local bbox = self:get_bbox()
  -- Each test checks if the box is outside the other box.
  -- The whole thing is negated because if the box is not
  -- outside of the other box, then it must be a collision.
  return not (
    bbox.x > other_bbox.x + other_bbox.w or
    bbox.x + bbox.w < other_bbox.x or
    bbox.y > other_bbox.y + other_bbox.h or
    bbox.y + bbox.h < other_bbox.y
  )
end

-- Get the bounding box.
function Ball:get_bbox()
  return {
    x = self.x - Ball.RADIUS,
    y = self.y - Ball.RADIUS,
    h = Ball.DIAMETER,
    w = Ball.DIAMETER,
  }
end

-- Set x and y speeds to produce a given angle for the ball.
function Ball:set_speeds()
  local angle = ANGLES[math.random(#ANGLES)]
  self.x_speed = SPEED * math.cos(math.pi * angle)
  self.y_speed = SPEED * math.sin(math.pi * angle)
end

function Ball:draw()
  love.graphics.circle('fill', self.x, self.y, Ball.RADIUS)
end

return Ball
