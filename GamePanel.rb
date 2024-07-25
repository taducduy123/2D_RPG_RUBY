
require 'ruby2d'
require_relative 'Character_Class/Player'
require_relative 'KeyHandler'
require_relative 'GameMap'
require_relative 'CommonParameter'
require_relative 'Character_Class/Monster'
require_relative 'Character_Class/Bat'
require_relative 'FindingPath/Node'
require_relative 'FindingPath/PathFinder'
require_relative 'Character_Class/Warrior'
include CCHECK


#
pFinder = PathFinder.new()




#1. Create objects in the game
map = GameMap.new()
player = Player.new(7*CP::TILE_SIZE, 7*CP::TILE_SIZE, CP::TILE_SIZE, CP::TILE_SIZE)
monsters = [Bat.new(480, 480, CP::TILE_SIZE, CP::TILE_SIZE, player),
            Bat.new(1000, 1000, CP::TILE_SIZE, CP::TILE_SIZE, player),
            Bat.new(1500, 1500, CP::TILE_SIZE, CP::TILE_SIZE, player)]
text = Text.new(
  '',
  x: 0, y: 0,
  #font: 'vera.ttf',
  style: 'bold',
  size: 20,
  color: 'black',
  #rotate: 90,
  #z: 10
)

firstNPC = Warrior.new(CP::TILE_SIZE * 3, CP::TILE_SIZE * 3,
CP::TILE_SIZE, CP::TILE_SIZE)

#1.1
pFinder = PathFinder.new()


#2. Get user's input
get_key_input(player)

#3.
#------------------------------------------------------- Game Loop ------------------------------------------
update do
    #1. Update Player
    player.updatePlayer(monsters, map, firstNPC)

    #2. Update all Monsters
    for i in 0..(monsters.length - 1)
      monsters[i].updateMonster(player, map, pFinder)
    end

    #3. Update Texts
    text.text = "Coordinate: #{player.worldX}  #{player.worldY} \n"

    # Update npc
    firstNPC.updateNPC(player, map)

    #4. Update Map
    map.update(player)


end



#------------------------------------------------------- Set up window ---------------------------------------
#Setting Window
set width: CP::SCREEN_WIDTH
set height: CP::SCREEN_HEIGHT
set title: "20x20 Grid RPG"
set resizable: true
set background: 'black'
#set fullscreen: true


#------------------------------------------------------- Show window ---------------------------------------
show
