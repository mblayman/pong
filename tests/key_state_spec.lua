require 'tests.love_mock'
local KeyState = require 'pong.key_state'

describe('KeyState', function()
  it('has unpressed keys', function()
    key_state = KeyState()

    assert.is_false(key_state.start)
  end)

  it('captures a pressed key', function()
    key_state = KeyState()
    stub(love.keyboard, 'isDown', true)

    key_state:update()

    assert.is_true(key_state.start)
  end)
end)
