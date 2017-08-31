-- anim8 has a mock newQuad implementation so use that as the starting point.
require 'pong.vendor.anim8.spec.love-mocks'

-- LOVE isn't installed with the rest of the Lua stuff so the API
-- is mocked out. Imperfect, but it works enough.

local Image = {
  getWidth = function() return 800 end,
  getHeight = function() return 600 end,
  setFilter = function() end
}

_G.love.keyboard = {}
_G.love.graphics.getWidth = function() return 800 end
_G.love.graphics.getHeight = function() return 600 end
_G.love.graphics.newImage = function() return Image end
