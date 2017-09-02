require 'tests.love_mock'

local Utils = require 'pong.utils'
local Ball = require 'pong.entities.ball'
local Paddle = require 'pong.entities.paddle'

describe('Utils', function()
  setup(function()
    Paddle.init()
  end)

  it('detects collision', function()
    local paddle = Paddle(0, 0)
    local ball = Ball()
    ball.x = 0
    ball.y = 0

    local collided = Utils.is_collision(ball, paddle)
    assert.is_true(collided)
  end)

  it('detects any collision', function()
    local paddle = Paddle(0, 0)
    local paddles = {[1] = paddle}
    local ball = Ball()
    ball.x = 0
    ball.y = 0

    local collided = Utils.has_any_collision(ball, paddles)
    assert.is_true(collided)
  end)
end)
