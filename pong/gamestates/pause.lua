local Gamestate = require 'pong.vendor.hump.gamestate'

local Pause = {}

function Pause:enter(from)
    self.from = from
end

function Pause:draw()
    local W, H = love.graphics.getWidth(), love.graphics.getHeight()

    -- Draw previous screen
    self.from:draw()

    -- Overlay with grey mask
    love.graphics.setColor(0, 0, 0, 100)
    love.graphics.rectangle('fill', 0, 0, W, H)

    -- Overlay with pause message
    love.graphics.setColor(255, 255, 255)
    love.graphics.printf('PAUSE', 0, H / 2, W, 'center')
end

function Pause:keypressed(key)
  if key == 'p' then
    Gamestate.pop()
  end
end

return Pause
