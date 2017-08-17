-- The ball that bounces back and forth.
local Ball = {}
Ball.__index = Ball

local function construct()
  local self = setmetatable({}, Ball)
  return self
end
setmetatable(Ball, {__call = construct})

function Ball:update(dt)
end

function Ball:draw()
end

return Ball
