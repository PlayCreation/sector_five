class Enemy
  MAX_SPEED = 5

  def initialize(window)
    @radius = 20
    @window = window
    @x = rand(window.width - 2 * @radius) + @radius
    @y = 0
    @image = Gosu::Image.new('images/enemy.png')

    @velocity_x = (rand(1) - 1) * rand(4)
    @velocity_y = rand(MAX_SPEED) + 1
  end

  def draw
    @image.draw(@x - @radius, @y - @radius, 1)
  end

  def move
    @x += @velocity_x
    @y += @velocity_y

    if @x > @window.width - @radius
      @velocity_x = -@velocity_x
      @x = @window.width - @radius
    elsif @x < @radius
      @velocity_x = -@velocity_x
      @x = @radius
    end

    if @y > @window.height + @radius
      @window.remove_enemy(self)
    end
  end
end
