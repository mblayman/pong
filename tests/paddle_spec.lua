require 'tests.love_mock'

local Constants = require 'pong.constants'
local Court = require 'pong.court'
local Paddle = require 'pong.entities.paddle'

describe('Paddle', function()
  setup(function()
    Paddle.init()
  end)

  local dt = 1

  it('has a height', function()
    assert.truthy(Paddle.HEIGHT)
  end)

  it('has a width', function()
    assert.truthy(Paddle.WIDTH)
  end)

  it('has a speed', function()
    assert.truthy(Paddle.SPEED)
  end)

  it('has a default direction', function()
    local paddle = Paddle(1, 2, 'left_player_up', 'left_player_down')

    assert.are.equal(Constants.UP, paddle.y_direction)
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

  it('moves up', function()
    local paddle = Paddle(1, 2, 'left_player_up', 'left_player_down')
    paddle.y_direction = Constants.DOWN

    paddle:update(dt, { left_player_up = true })

    assert.are.equal(Constants.UP, paddle.y_direction)
    assert.is_true(paddle.y < 2)
  end)

  it('moves down', function()
    local paddle = Paddle(1, 2, 'left_player_up', 'left_player_down')
    paddle.y_direction = Constants.UP

    paddle:update(dt, { left_player_down = true })

    assert.are.equal(Constants.DOWN, paddle.y_direction)
    assert.is_true(paddle.y > 2)
  end)

  it('gets the bounding box', function()
    local paddle = Paddle(1, 2, 'left_player_up', 'left_player_down')

    local bbox = paddle:get_bbox()

    assert.are.equal(1, bbox.x)
    assert.are.equal(2, bbox.y)
    assert.are.equal(Paddle.HEIGHT, bbox.h)
    assert.are.equal(Paddle.WIDTH, bbox.w)
  end)

  it('collides with the top of the court', function()
    local paddle = Paddle(1, -2, 'left_player_up', 'left_player_down')

    assert.is_true(paddle:collide_top())
  end)

  it('collides with the bottom of the court', function()
    local paddle = Paddle(
      1, Court.BOTTOM - Paddle.HEIGHT + 1, 'left_player_up', 'left_player_down')

    assert.is_true(paddle:collide_bottom())
  end)
end)
