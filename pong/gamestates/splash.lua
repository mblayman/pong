local Gamestate = require 'pong.vendor.hump.gamestate'
local Timer = require 'pong.vendor.hump.timer'

local Ingame = require 'pong.gamestates.ingame'

local Splash = {}

function Splash:init()
  self.timer = Timer.after(2, function() Gamestate.switch(Ingame) end)
end


function Splash:draw()
    local H, W = love.graphics.getHeight(), love.graphics.getWidth()
    love.graphics.printf('int d Games', 0, H / 2, W, 'center')
end

function Splash:keypressed(key)
  Timer.cancel(self.timer)
  Gamestate.switch(Ingame)
end

return Splash
