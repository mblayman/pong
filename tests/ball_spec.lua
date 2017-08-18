require 'tests.love_mock'

local Constants = require 'pong.constants'
local Ball = require 'pong.entities.ball'

describe('Ball', function()
  local dt = 1

  it('has a ready state', function()
    assert.truthy(Ball.READY_STATE)
  end)

  it('has a moving state', function()
    assert.truthy(Ball.MOVING_STATE)
  end)

  it('starts at ready', function()
    local ball = Ball()

    assert.are.equal(Ball.READY_STATE, ball.state)
  end)

  it('has default x direction', function()
    local ball = Ball()

    assert.are.equal(Constants.RIGHT, ball.x_direction)
  end)

  it('has default y direction')

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
      local ball = Ball()
      ball.x = 200
      ball.x_direction = Constants.LEFT
      ball.state = Ball.MOVING_STATE

      ball:update(dt, {})

      assert.are.equal(72, ball.x)
    end)
  end)
end)
