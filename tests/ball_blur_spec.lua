require 'tests.love_mock'

local BallBlur = require 'pong.entities.ball_blur'

describe('BallBlur', function()
  it('has opacity fade', function()
    assert.truthy(BallBlur.OPACITY_FADE)
  end)

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

  it('decreases opacity on update', function()
    local ball_blur = BallBlur(42, 24, 16)
    local previous_opacity = ball_blur.opacity

    ball_blur:update()

    assert.is_true(previous_opacity > ball_blur.opacity)
  end)

  it('destroys when opacity drops to zero', function()
    local ball_blur = BallBlur(42, 24, 16)
    ball_blur.opacity = BallBlur.OPACITY_FADE - 1

    ball_blur:update()

    assert.is_true(ball_blur.destroy)
  end)
end)
