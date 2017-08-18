require 'tests.love_mock'
local Ball = require 'pong.entities.ball'

describe('Ball', function()
  it('has a ready state', function()
    assert.truthy(Ball.READY_STATE)
  end)

  it('starts at ready', function()
    local ball = Ball()

    assert.are.equal(Ball.READY_STATE, ball.state)
  end)
end)
