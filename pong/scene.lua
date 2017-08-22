local Scene = {}
Scene.__index = Scene

local function construct()
  local self = setmetatable({}, Scene)

  self.paddles = {}

  return self
end
setmetatable(Scene, {__call = construct})

function Scene:add_paddle(paddle)
  table.insert(self.paddles, paddle)
end

return Scene
