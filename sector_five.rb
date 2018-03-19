require 'gosu'

require_relative './enemy.rb'
require_relative './player.rb'
require_relative './bullet.rb'
require_relative './explosion.rb'

class SectorFive < Gosu::Window
  WINDOW_HEIGHT = 800
  WINDOW_WIDTH = 800
  ENEMY_FREQUENCY = 0.03

  def initialize
    super(WINDOW_WIDTH, WINDOW_HEIGHT)
    self.caption = 'Sector Five'

    @player = Player.new(self)
    @enemies = []

    @bullets = []
    @explosions = []
  end

  def draw
    @player.draw
    @enemies.each(&:draw)
    @bullets.each(&:draw)
    @explosions.each(&:draw)
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
    @bullets.each(&:move)

    @enemies.dup.each do |enemy|
      @bullets.dup.each do |bullet|
        distance = Gosu.distance(enemy.x, enemy.y, bullet.x, bullet.y)
        if distance < enemy.radius + bullet.radius
          @enemies.delete enemy
          @bullets.delete bullet
          @explosions.push Explosion.new(self, enemy.x, enemy.y)
        end
      end
    end

    @explosions.dup.each do |explosion|
      @explosions.delete explosion if explosion.finished
    end

    @enemies.dup.each do |enemy|
      if enemy.y > WINDOW_HEIGHT + enemy.radius
        @enemies.delete enemy
      end
    end

    @bullets.dup.each do |bullet|
      @bullets.delete bullet unless bullet.onscreen?
    end
  end

  def button_down(id)
    if id == Gosu::KbSpace
      @bullets.push Bullet.new(self, @player.x, @player.y, @player.angle)
    end
  end

  def remove_enemy(enemy)
    @enemies.delete(enemy)
  end

  def remove_explosion(explosion)
    @explosions.delete(explosion)
  end
end

window = SectorFive.new
window.show
