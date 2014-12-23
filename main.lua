ROT = require "vendor/rotLove/rotLove"

require "classes/thing"
require "classes/map"

SCREEN_WIDTH = 37
SCREEN_HEIGHT = 37
LEVEL_WIDTH = 23
LEVEL_HEIGHT = 21

function love.load()
  display = ROT.Display:new(LEVEL_WIDTH, LEVEL_HEIGHT)
  player = Thing:new{character='@', color="yellow", xpos=1, ypos=1}
  map = Map:new()
end

function love.draw()
  display:draw()
end

function love.update(dt)
  map:draw()

  display:write("xpos: " .. player.xpos, 1, LEVEL_HEIGHT - 1)
  display:write("ypos: " .. player.ypos, 1, LEVEL_HEIGHT)

  player:draw()
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
