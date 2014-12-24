ROT = require "vendor/rotLove/rotLove"

require "utils"
require "classes/thing"
require "classes/map"

SCREEN_WIDTH = 37
SCREEN_HEIGHT = 37
LEVEL_WIDTH = 23
LEVEL_HEIGHT = 21

function love.load()
  love.keyboard.setKeyRepeat(true)

  display = ROT.Display:new(LEVEL_WIDTH, LEVEL_HEIGHT)

  player = Thing:new{character='@', color="yellow", xpos=1, ypos=1}
  player.score = 0

  map = Map:new("data/level1.txt")
end

function love.draw()
  display:draw()
end

function love.update(dt)
  map:draw()

  display:write("score: " .. player.score, 1, LEVEL_HEIGHT)

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
