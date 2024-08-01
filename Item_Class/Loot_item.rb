require 'ruby2d'

#NOTES: ALL ITEMS are CONSUMABLES

class Meat  # Regain health
  attr_accessor  :image_path, :visible
  def initialize()
    @image_path = 'Image/Meat.png'
  end

  def effect
    healthRegain = 60
    return healthRegain
  end


end

class RottedItem   # Reduce health
  attr_accessor :image_path, :visible
  def initialize()
    @image_path = 'Image/Meat.png'
  end

  def effect
    healthRegain = -60
    return healthRegain
  end
end
