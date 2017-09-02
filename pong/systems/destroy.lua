local System = require 'pong.vendor.knife.knife.system'

-- Destroy entities marked for destruction.
return System(
  {'-destroy'},
  function(entities, destroyed_index)
    table.remove(entities, destroyed_index)
  end
)
