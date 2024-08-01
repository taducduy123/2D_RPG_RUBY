require 'ruby2d'
require_relative 'HealthBar'
require_relative '../ImageHandler' # to read dimemsion of image ==> must install (gem install rmagick)
require_relative '../CollisionChecker'
require_relative '../CommonParameter'
require_relative 'Monster'
include CCHECK

class Skeleton < Monster
  def initialize(wordlX, worldY, width, height, player)
    super(wordlX, worldY, width, height)

    #1. Image and Animation
    @image = Sprite.new(
      'Image/Skeleton.png',
      x: @worldX - player.worldX + player.x,
      y: @worldY - player.worldY + player.y,
      width: width, height: height,
      # clip_width: width_Of('Image/cropskeleton.png') / 10,
      # clip_height: height_Of('Image/cropskeleton.png'),
      animations: {
        walk:
        [
           {
             x: 0, y: 0,
             width: 32, height: 49,
             time: 180, flip: :none
           },
           {
             x: 39, y: 0,
             width: 32, height: 49,
             time: 180, flip: :none
           },
           {
             x: 74, y: 0,
             width: 36, height: 49,
             time: 180, flip: :none
           },
           {
             x: 113, y: 0,
             width: 37, height: 49,
             time: 180, flip: :none
           },
           {
             x: 152, y: 0,
             width: 40, height: 49,
             time: 180, flip: :none
           },
           {
             x: 192, y: 0,
             width: 40, height: 49,
             time: 180, flip: :none
           },
           {
             x: 238, y: 0,
             width: 35, height: 49,
             time: 180, flip: :none
           },
           {
             x: 357, y: 0,
             width: 33, height: 49,
             time: 180, flip: :none
           }
         ]

       },
    )
    @image.play

    #2. Health Bar
    @healthBar = HealthBar.new(100, 100, -999, -999, 48)

    #3. Speed
    @speed = 2

    #3.1. Attack
    @attack = 10

    #4. This will be convenient for random move function
    @moveCounter = 0


  end
  

#-------------------------------- Override Methods -----------------------------------------
def updateMonster(player, map, items, npcs, monsters)  
  if(@exist == true)
    self.DrawMonster(player)
    self.DrawHealthBar(player)
    self.randMove(player, map, items, npcs, monsters)
    # self.moveForwardTo((player.worldY + player.solidArea.y) / CP::TILE_SIZE, (player.worldX + player.solidArea.x) / CP::TILE_SIZE, 
    #                     player, map, pFinder, items, npcs, monsters)

    if @healthBar.isDead?
      @exist = false
    end
    # Check if collision with player then attack at right time
    if @onAttackBox
      self.attackTarget(player)
    end
  else
    self.removeMonster
    @existFlag = true
  end
end


#------------------------------ Random Move ---------------------------------------------------
  def randMove(player, map, items, npcs, monsters)

    @moveCounter = @moveCounter + 1
    # generate a random number after every 120 steps
    if(@moveCounter == 100)
      @upDirection = false
      @downDirection = false
      @leftDirection = false
      @rightDirection = false

      ranNum = rand(1..100)
      if(1 <= ranNum && ranNum <= 25)
        @upDirection = true
      elsif(25 < ranNum && ranNum <= 50)
        @downDirection = true
      elsif(50 < ranNum && ranNum <= 75)
        @leftDirection = true
      else
        @rightDirection = true
      end
    @moveCounter = 0 #reset moveCounter
    end


    # Checking collision before moving
    self.checkCollision(player, map, items, npcs, monsters)

    # If no collision is detected, then move the monster
    if(@collisionOn == false)
      if(self.upDirection == true)
        @worldY -= @speed
        self.runAnimation
      elsif(self.downDirection == true)
        @worldY += @speed
        self.runAnimationLeft
      elsif(self.leftDirection == true)
        @worldX -= @speed
        self.runAnimationLeft
      elsif(self.rightDirection == true)
        @worldX += @speed
        self.runAnimation
      end
    else
      self.stopAnimation
    end
  end


end
