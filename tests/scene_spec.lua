require 'tests.love_mock'

local Scene = require 'pong.scene'

describe('Scene', function()
  it('has goals', function()
    local scene = Scene()

    assert.truthy(scene.goals)
  end)

  it('has paddles', function()
    local scene = Scene()

    assert.truthy(scene.paddles)
  end)

  it('adds a goal', function()
    local goal = {}
    local scene = Scene()

    scene:add_goal(goal)

    assert.equal(goal, scene.goals[1])
  end)

  it('adds a paddle', function()
    local paddle = {}
    local scene = Scene()

    scene:add_paddle(paddle)

    assert.equal(paddle, scene.paddles[1])
  end)
end)
