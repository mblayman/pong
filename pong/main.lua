local Gamestate = require 'pong.vendor.hump.gamestate'

local Ingame = require 'pong.gamestates.ingame'

-- Lua's random number generator doesn't have enough entropy to start.
-- Without some initial calls, the first random is always the same.
local function init_random()
  math.randomseed(os.time())
  math.random()
  math.random()
  math.random()
end

function love.load()
  init_random()
  Gamestate.registerEvents()
  Gamestate.switch(Ingame)
end
