require 'gosu'

require_relative './player.rb'

class SectorFive < Gosu::Window
  WINDOW_HEIGHT = 800
  WINDOW_WIDTH = 800

  def initialize
    super(WINDOW_WIDTH, WINDOW_HEIGHT)
    self.caption = 'Sector Five'

    @player = Player.new(self)
  end

  def draw
    @player.draw
  end

  def update
    @player.turn_left if  button_down?(Gosu::KbLeft)
    @player.turn_right if  button_down?(Gosu::KbRight)

    @player.accelerate if button_down?(Gosu::KbUp)
    @player.move
  end
end

window = SectorFive.new
window.show
