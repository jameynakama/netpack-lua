ROT = require "vendor/rotLove/rotLove"

require("classes/thing")
require "classes/player"

LEVEL_WIDTH = 23
LEVEL_HEIGHT = 21

function love.load()
  display = ROT.Display:new(LEVEL_WIDTH, LEVEL_HEIGHT)
  player = Player:new()
end

function love.draw()
  display:draw()
end

function love.update(dt)
  for i=1,LEVEL_WIDTH do
    for j=1,LEVEL_HEIGHT do
      display:write(' ', i, j)
    end
  end

  display:write("xpos: " .. player.xpos, 1, LEVEL_HEIGHT - 1)
  display:write("ypos: " .. player.ypos, 1, LEVEL_HEIGHT)

  display:write(player.character, player.xpos, player.ypos, player.color)
end

function love.keypressed(key)
  if key == 'j' then
    if player.ypos < LEVEL_HEIGHT then
      player.ypos = player.ypos + 1
    end
  elseif key == 'k' then
    if player.ypos > 1 then
      player.ypos = player.ypos - 1
    end
  elseif key == 'l' then
    if player.xpos < LEVEL_WIDTH then
      player.xpos = player.xpos + 1
    end
  elseif key == 'h' then
    if player.xpos > 1 then
      player.xpos = player.xpos - 1
    end
  end
end
