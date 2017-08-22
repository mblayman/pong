require 'tests.love_mock'

local Scene = require 'pong.scene'

describe('Scene', function()
  it('has paddles', function()
    local scene = Scene()

    assert.truthy(scene.paddles)
  end)

  it('adds a paddle', function()
    local paddle = {}
    local scene = Scene()

    scene:add_paddle(paddle)

    assert.equal(paddle, scene.paddles[1])
  end)
end)
