local Utils = {}

-- Check if two entities collide.
function Utils.is_collision(entity, other_entity)
  bbox, other_bbox = entity:get_bbox(), other_entity:get_bbox()
  -- Each test checks if the box is outside the other box.
  -- The whole thing is negated because if the box is not
  -- outside of the other box, then it must be a collision.
  return not (
    bbox.x > other_bbox.x + other_bbox.w or
    bbox.x + bbox.w < other_bbox.x or
    bbox.y > other_bbox.y + other_bbox.h or
    bbox.y + bbox.h < other_bbox.y
  )
end

-- Check if an entity collides with any entity in a table.
function Utils.has_any_collision(entity, other_entities)
  for i, other_entity in pairs(other_entities) do
    if Utils.is_collision(entity, other_entity) then
      return true
    end
  end
  return false
end

return Utils
