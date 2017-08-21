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
    local paddle = Paddle(1, 2, 'left_player_up', 'left_player_down')

    assert.are.equal(1, paddle.x)
  end)

  it('is given y', function()
    local paddle = Paddle(1, 2, 'left_player_up', 'left_player_down')

    assert.are.equal(2, paddle.y)
  end)

  it('is given an up key', function()
    local paddle = Paddle(1, 2, 'left_player_up', 'left_player_down')

    assert.are.equal('left_player_up', paddle.up_key)
  end)

  it('is given a down key', function()
    local paddle = Paddle(1, 2, 'left_player_up', 'left_player_down')

    assert.are.equal('left_player_down', paddle.down_key)
  end)
end)
