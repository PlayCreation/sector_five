require 'gosu'

class Player
  ACCELERATION = 2
  FRICTION = 0.1
  ROTATION_SPEED = 3

  attr_reader :x, :y, :angle, :radius

  def initialize(window)
    @x = 200
    @y = 200
    @angle = 0

    @ship_image = Gosu::Image.new('images/ship.png')
    @thrust_image = Gosu::Image.new('images/ship_thrust.png')
    @image = @ship_image

    @velocity_x = 0
    @velocity_y = 0
    @radius = 20
    @window = window
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
    @image = @ship_image
  end

  def turn_right
    @angle += ROTATION_SPEED
  end

  def turn_left
    @angle -= ROTATION_SPEED
  end

  def move
    @x += @velocity_x
    @y += @velocity_y
    @velocity_x *= (1.0 - FRICTION)
    @velocity_y *= (1.0 - FRICTION)

    if @x > @window.width - @radius
      @velocity_x = -@velocity_x
      @x = @window.width - @radius
    elsif @x < @radius
      @velocity_x = -@velocity_x
      @x = @radius
    end

    if @y > @window.height - @radius
      @velocity_y = -@velocity_y
      @y = @window.height - @radius
    elsif @y < @radius
      @velocity_y = -@velocity_y
      @y = @radius
    end
  end

  def accelerate
    @image = @thrust_image
    @velocity_x += Gosu.offset_x(@angle, ACCELERATION)
    @velocity_y += Gosu.offset_y(@angle, ACCELERATION)
  end
end
