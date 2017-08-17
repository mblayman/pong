function love.load()
end

function love.update(dt)
end

function love.draw()
  local mid_x = love.graphics.getWidth() / 2
  love.graphics.line(mid_x, 0, mid_x, love.graphics.getHeight())
end
