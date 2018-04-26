class Credit
  SPEED = 1
  attr_reader :y

  def initialize(window, text, x, y)
    @initial_y = window.height
    @x = x
    @y = y
    @text = text
    @font = Gosu::Font.new(24)
  end

  def move
    @y -= SPEED
    reset if @y < 0
  end

  def draw
    @font.draw(@text, @x, @y, 1)
  end

  def reset
    @y = @initial_y
  end
end
