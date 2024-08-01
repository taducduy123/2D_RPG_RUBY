require 'ruby2d'
require_relative '../CollisionChecker'
require_relative '../CommonParameter'
require_relative '../WorldHandler'
require_relative '../ImageHandler'
InventorySize = 9 / 3 # for 3x3 inventory
TILE_SIZE = 100
# Create a class for the inventory
class Inventory
  attr_accessor :cursor_x, :cursor_y, :visible, :IsFull

  def initialize
    @visible = false
    @IsFull = false
    @held_items_col = 0
    @held_items_row = 0
    @my_inventory = Array.new(InventorySize) { Array.new(InventorySize, nil) }
    @cursor
    @cursor_x = 0
    @cursor_y = 0
    @created_objects = []
  end


  def draw_grid
    @my_inventory.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        rect = Rectangle.new(
          x: x * TILE_SIZE + Window.width / 3, y: y * TILE_SIZE + Window.height / 4,
          width: TILE_SIZE - 2, height: TILE_SIZE - 2,
          color: 'black',
          z: 3
        )
        @created_objects << rect

        if @my_inventory[y][x]
          img = Image.new(
            @my_inventory[y][x].image_path,
            x: x * TILE_SIZE + Window.width / 3, y: y * TILE_SIZE + Window.height / 4,
            width: TILE_SIZE - 2, height: TILE_SIZE - 2,
            z: 4
          )
          @created_objects << img
        end
      end
    end
  end
  def draw_cursor
    @cursor = Image.new(
      'Image/cursor.png',
      x: @cursor_x * TILE_SIZE + Window.width / 3, y: @cursor_y * TILE_SIZE + Window.height / 4,
      width: TILE_SIZE - 2, height: TILE_SIZE - 2,
      z: 5
    )
  end

  def move_cursor(dx, dy)
    @cursor_x = (@cursor_x + dx) % InventorySize
    @cursor_y = (@cursor_y + dy) % InventorySize
    itemManage(@cursor_y, @cursor_x)
    @cursor.x = @cursor_x * TILE_SIZE + Window.width / 3
    @cursor.y = @cursor_y * TILE_SIZE + Window.height / 4
  end

  def add_to_inventory(loot) # Methods to add items properly
    if @held_items_row < @my_inventory.size
      @my_inventory[@held_items_row][@held_items_col] = loot[0] # WORKS only 1 item in chest
      @held_items_col += 1
      if @held_items_col != 0 && @held_items_col % InventorySize == 0
        @held_items_col = 0
        @held_items_row += 1
      end
    else
      @IsFull = true
      print @IsFull
    end

  end

  def display
    itemManage(0, 0)
    draw_grid
    draw_cursor
  end

  def hide
    @created_objects.each(&:remove)
    @created_objects.clear
    @cursor.remove
  end

  def itemManage(x, y)
      puts "Access my_inventory at #{x} #{y}"
  end

end
