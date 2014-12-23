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
  player.score = 0

  map = Map:new()

  for i=4,10 do
    table.insert(map.matrix[i][10], Thing:new{character='#', color='orange', solid=true})
  end
  for i=3, 7 do
    table.insert(map.matrix[4][i], Thing:new{name="pellet", character='.', collectible=true, points=1})
  end
end

function love.draw()
  display:draw()
end

function love.update(dt)
  map:draw()

  display:write("score: " .. player.score, 1, LEVEL_HEIGHT - 2)
  display:write("xpos: " .. player.xpos, 1, LEVEL_HEIGHT - 1)
  display:write("ypos: " .. player.ypos, 1, LEVEL_HEIGHT)

  player:draw()
end

function love.keypressed(key)
  -- clear everything that moves before changing the position of anything
  player:clear()

  local potential_move = {}

  if key == 'j' then
    potential_move = {player.xpos, player.ypos + 1}
  elseif key == 'k' then
    potential_move = {player.xpos, player.ypos - 1}
  elseif key == 'l' then
    potential_move = {player.xpos + 1, player.ypos}
  elseif key == 'h' then
    potential_move = {player.xpos - 1, player.ypos}
  else
    return
  end

  if not map:is_blocked(potential_move) then
    player:move(potential_move)
    local collectibles = map:get_collectibles(potential_move)
    for i, collectible in ipairs(collectibles) do
      player.score = player.score + collectible.points
    end
  end
end
