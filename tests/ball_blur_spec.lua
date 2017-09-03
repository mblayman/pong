require 'tests.love_mock'

local BallBlur = require 'pong.entities.ball_blur'

describe('BallBlur', function()
  it('has initial opacity', function()
    local ball_blur = BallBlur(42, 24, 16)

    assert.are.equal(BallBlur.INITIAL_OPACITY, ball_blur.opacity)
  end)

  it('is given x', function()
    local ball_blur = BallBlur(42, 24, 16)

    assert.are.equal(42, ball_blur.x)
  end)

  it('is given y', function()
    local ball_blur = BallBlur(42, 24, 16)

    assert.are.equal(24, ball_blur.y)
  end)

  it('is given a radius', function()
    local ball_blur = BallBlur(42, 24, 16)

    assert.are.equal(16, ball_blur.radius)
  end)
end)
