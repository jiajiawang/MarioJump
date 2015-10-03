class MainScene < MG::Scene
  def initialize
    self.gravity = [0, -900]

    add_mario
    add_ground
  end

  def add_ground
    1.upto(15) do |offset|
      block = MG::Sprite.new('block.png')
      block.attach_physics_box
      block.dynamic = false
      block.position = [200 + (offset-1) * 48, 100]
      add block
    end
  end

  def add_mario
    @mario = MG::Sprite.new('mario_1.png')
    @mario.position = [200, 200]
    @mario.attach_physics_box
    add @mario
  end
end
