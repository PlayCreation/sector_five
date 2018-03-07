class Explosion
  def initialize(window, x, y)
    @window = window
    @x = x
    @y = y
    @radius = 30
    @images = Gosu::Image.load_tiles('images/explosions.png', 60, 60)
    @image_index = 0
    @finished = false
  end

  def draw
    if @image_index < @images.count
      @images[@image_index].draw(@x - @radius, @y - @radius, 2)
      @image_index += 1
    else
      @finished = true
      @window.remove_explosion self
    end
  end
end
