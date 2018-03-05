require 'gosu'

require_relative './enemy.rb'
require_relative './player.rb'

class SectorFive < Gosu::Window
  WINDOW_HEIGHT = 800
  WINDOW_WIDTH = 800
  ENEMY_FREQUENCY = 0.03

  def initialize
    super(WINDOW_WIDTH, WINDOW_HEIGHT)
    self.caption = 'Sector Five'

    @player = Player.new(self)
    @enemies = []
  end

  def draw
    @player.draw
    @enemies.each(&:draw)
  end

  def update
    @player.turn_left if  button_down?(Gosu::KbLeft)
    @player.turn_right if  button_down?(Gosu::KbRight)

    @player.accelerate if button_down?(Gosu::KbUp)
    @player.move

    if rand < ENEMY_FREQUENCY
      @enemies.push Enemy.new(self)
    end

    @enemies.each(&:move)
  end

  def remove_enemy(enemy)
    @enemies.delete(enemy)
  end
end

window = SectorFive.new
window.show
