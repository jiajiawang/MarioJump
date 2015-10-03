class MainScene < MG::Scene
  def initialize
    add_mario
  end

  def add_mario
    @mario = MG::Sprite.new('mario_1.png')
    @mario.position = [200, 200]
    @mario.attach_physics_box
    add @mario
  end
end
