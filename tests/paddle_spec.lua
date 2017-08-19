require 'tests.love_mock'

local Paddle = require 'pong.entities.paddle'

describe('Paddle', function()
  it('has a height', function()
    assert.truthy(Paddle.HEIGHT)
  end)

  it('has a width', function()
    assert.truthy(Paddle.WIDTH)
  end)

  it('is given x', function()
    local paddle = Paddle(1, 2)

    assert.are.equal(1, paddle.x)
  end)

  it('is given y', function()
    local paddle = Paddle(1, 2)

    assert.are.equal(2, paddle.y)
  end)
end)
