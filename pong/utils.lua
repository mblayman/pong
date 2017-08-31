local Utils = {}

-- Check if two bounding boxes collide.
function Utils.is_collision(bbox, other_bbox)
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

return Utils
