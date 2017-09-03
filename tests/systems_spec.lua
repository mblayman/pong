require 'tests.love_mock'

local destroy = require 'pong.systems.destroy'

describe('destroy', function()
  it('removes an entity marked for destruction', function()
    entities = {}
    entity = {destroy = true}
    table.insert(entities, entity)

    destroy(entity, entities, 1)

    assert.are.equal(0, #entities)
  end)

  it('ignores entities not marked for destruction', function()
    entities = {}
    entity = {destroy = false}
    table.insert(entities, entity)

    destroy(entity, entities, 1)

    assert.are.equal(1, #entities)
  end)
end)
