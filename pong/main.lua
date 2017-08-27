local Gamestate = require 'pong.vendor.hump.gamestate'
local Timer = require 'pong.vendor.hump.timer'

local Ingame = require 'pong.gamestates.ingame'
local Pause = require 'pong.gamestates.pause'
local Splash = require 'pong.gamestates.splash'

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
  Gamestate.switch(Splash)
end

function love.update(dt)
  Timer.update(dt)
end

function love.keypressed(key)
  if Gamestate.current() == Ingame and key == 'p' then
    Gamestate.push(Pause)
  end

  if key == 'escape' then
    love.event.quit()
  end
end
