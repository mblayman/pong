-- LOVE isn't installed with the rest of the Lua stuff so the API
-- is mocked out. Imperfect, but it works enough.
love = {
  keyboard = {
  },
  graphics = {
    getWidth = function() return 800 end,
    getHeight = function() return 600 end
  }
}