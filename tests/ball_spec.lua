require 'tests.love_mock'

local Constants = require 'pong.constants'
local Goal = require 'pong.goal'
local Scene = require 'pong.scene'
local Ball = require 'pong.entities.ball'
local Paddle = require 'pong.entities.paddle'

describe('Ball', function()
  setup(function()
    Paddle.init()
  end)

  local dt = 1

  it('has a ready state', function()
    assert.truthy(Ball.READY_STATE)
  end)

  it('has a moving state', function()
    assert.truthy(Ball.MOVING_STATE)
  end)

  it('has a scoring state', function()
    assert.truthy(Ball.SCORING_STATE)
  end)

  it('gets a scene', function()
    local scene = {}
    local ball = Ball(scene)

    assert.equal(scene, ball.scene)
  end)

  it('starts at ready', function()
    local ball = Ball()

    assert.are.equal(Ball.READY_STATE, ball.state)
  end)

  it('has default x direction', function()
    local ball = Ball()

    assert.are.equal(Constants.RIGHT, ball.x_direction)
  end)

  it('has default x speed', function()
    local ball = Ball()

    assert.are.equal(0, ball.x_speed)
  end)


  it('has default y direction', function()
    local ball = Ball()

    assert.are.equal(Constants.DOWN, ball.y_direction)
  end)

  it('has default y speed', function()
    local ball = Ball()

    assert.are.equal(0, ball.y_speed)
  end)

  it('did not just bounce x', function()
    local ball = Ball()

    assert.is_false(ball.just_x_bounced)
  end)

  it('did not just bounce y', function()
    local ball = Ball()

    assert.is_false(ball.just_y_bounced)
  end)

  it('sets speeds', function()
    local ball = Ball()

    ball:set_speeds()

    assert.are_not.equal(0, ball.x_speed)
    assert.are_not.equal(0, ball.y_speed)
  end)

  it('gets a bounding box', function()
    local ball = Ball()
    ball.x = 100
    ball.y = 200

    bbox = ball:get_bbox()

    assert.are.equal(100 - Ball.RADIUS, bbox.x)
    assert.are.equal(200 - Ball.RADIUS, bbox.y)
    assert.are.equal(Ball.DIAMETER, bbox.h)
    assert.are.equal(Ball.DIAMETER, bbox.w)
  end)

  it('reverses at the top', function()
    local ball = Ball()
    ball.y = 0
    ball.y_direction = Constants.UP

    ball:update_collide_y(dt)

    assert.are.equal(Constants.DOWN, ball.y_direction)
  end)

  it('reverses at the bottom', function()
    local ball = Ball()
    ball.y = love.graphics.getHeight()
    ball.y_direction = Constants.DOWN

    ball:update_collide_y(dt)

    assert.are.equal(Constants.UP, ball.y_direction)
  end)

  it('does nothing in the y bounce cooldown', function()
    local ball = Ball()
    ball.y = love.graphics.getHeight()
    ball.y_direction = Constants.DOWN
    ball.just_y_bounced = true

    ball:update_collide_y(dt)

    assert.are.equal(Constants.DOWN, ball.y_direction)
  end)

  describe('on start', function()
    local key_state = { start = true }

    it('starts moving', function()
      local ball = Ball()

      ball:update(dt, key_state)

      assert.are.equal(Ball.MOVING_STATE, ball.state)
    end)

    it('has x direction', function()
      local ball = Ball()
      stub(math, 'random', 1)

      ball:update(dt, key_state)

      assert.are.equal(Constants.LEFT, ball.x_direction)
    end)

    it('has y direction')
  end)

  describe('while moving', function()
    it('updates x', function()
      local scene = Scene()
      local ball = Ball(scene)
      ball.x = 200
      ball.x_speed = 128
      ball.x_direction = Constants.LEFT
      ball.state = Ball.MOVING_STATE

      ball:update(dt, {})

      assert.are.equal(72, ball.x)
    end)

    it('reverses against a paddle', function()
      local paddle = Paddle(0, 0)
      local scene = Scene()
      scene:add_paddle(paddle)
      local ball = Ball(scene)
      ball.x = 0
      ball.y = 0
      ball.x_direction = Constants.LEFT
      ball.state = Ball.MOVING_STATE

      ball:update(dt, {})

      assert.are.equal(Constants.RIGHT, ball.x_direction)
    end)

    it('does nothing in the x bounce cooldown', function()
      local paddle = Paddle(0, 0)
      local scene = Scene()
      scene:add_paddle(paddle)
      local ball = Ball(scene)
      ball.x = 0
      ball.y = 0
      ball.x_direction = Constants.LEFT
      ball.state = Ball.MOVING_STATE
      ball.just_x_bounced = true

      ball:update(dt, {})

      assert.are.equal(Constants.LEFT, ball.x_direction)
    end)

    it('scores a goal', function()
      local goal = Goal(0, 0, love.graphics.getHeight())
      local scene = Scene()
      scene:add_goal(goal)
      local ball = Ball(scene)
      ball.x = 0
      ball.y = 0
      ball.state = Ball.MOVING_STATE

      ball:update(dt, {})

      assert.are.equal(Ball.SCORING_STATE, ball.state)
    end)
  end)

  describe('while scoring', function()
    it('updates x', function()
      local scene = Scene()
      local ball = Ball(scene)
      ball.x = 200
      ball.x_speed = 128
      ball.x_direction = Constants.LEFT
      ball.state = Ball.SCORING_STATE

      ball:update(dt, {})

      assert.are.equal(72, ball.x)
    end)
  end)
end)
