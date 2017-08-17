-- Map user inputs to game keys
local KeyState = {}
KeyState.__index = KeyState

local key_map = {
  start = 'space',
  left_player_up = 'w',
  left_player_down = 's',
  right_player_up = 'up',
  right_player_down = 'down',
}

local function construct()
  local self = setmetatable({}, KeyState)

  for input, key in pairs(key_map) do
    self[input] = false
  end

  return self
end
setmetatable(KeyState, {__call = construct})

function KeyState:update()
  for input, key in pairs(key_map) do
    self[input] = love.keyboard.isDown(key)
  end
end

return KeyState
