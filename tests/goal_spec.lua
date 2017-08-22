require 'tests.love_mock'

local Goal = require 'pong.goal'

describe('Goal', function()
  it('has width', function()
    assert.truthy(Goal.WIDTH)
  end)

  it('gets x', function()
    local goal = Goal(1, 2, 3)

    assert.are.equal(1, goal.x)
  end)

  it('gets y', function()
    local goal = Goal(1, 2, 3)

    assert.are.equal(2, goal.y)
  end)

  it('gets height', function()
    local goal = Goal(1, 2, 3)

    assert.are.equal(3, goal.height)
  end)

  it('gets the bounding box', function()
    local goal = Goal(1, 2, 3)

    local bbox = goal:get_bbox()

    assert.are.equal(1, bbox.x)
    assert.are.equal(2, bbox.y)
    assert.are.equal(3, bbox.h)
    assert.are.equal(Goal.WIDTH, bbox.w)
  end)
end)
