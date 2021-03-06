class MainScene < MG::Scene
  MARIO = 1
  GROUND = 2

  def initialize
    self.gravity = [0, -900]

    add_mario
    add_ground

    @on_ground = false
    @block_update = 0
    @random = Random.new
    @game_over = false

    on_touch_begin do
      if @game_over
        MG::Director.shared.replace(MainScene.new)
      end
      if @on_ground
        MG::Audio.play('jump.wav')
        @on_ground = false
        @mario.velocity = [0, 400]
      end
    end

    on_contact_begin do
      @on_ground = true
      @mario.velocity = [0, 0]
      true
    end

    start_update
  end

  def add_ground
    1.upto(18) do |offset|
      block = MG::Sprite.new('block.png')
      block.attach_physics_box
      block.dynamic = false
      block.position = [200 + (offset-1) * 48, 100]
      block.category_mask = GROUND
      block.contact_mask = MARIO
      add block
      block.move_by([-1500, 0], 5.0) { block.delete_from_parent  }
    end
  end

  def add_mario
    @mario = MG::Sprite.new('mario_1.png')
    @mario.position = [200, 200]
    @mario.attach_physics_box
    @mario.category_mask = MARIO
    @mario.contact_mask = GROUND
    @mario.animate(['mario_1.png', 'mario_2.png', 'mario_3.png'], 0.1, :forever)
    add @mario
  end

  def add_block
    number = @random.rand(1..5)
    1.upto(number) do |offset|
      block = MG::Sprite.new('block.png')
      block.attach_physics_box
      block.dynamic = false
      block.category_mask = GROUND
      block.contact_mask = MARIO
      block.position = [MG::Director.shared.size.width + offset * 48, 100]
      add block
      block.move_by([-1500, 0], 5.0) { block.delete_from_parent  }
    end
  end

  def update(delta)
    if @mario.position.y < 0
      MG::Audio.play('game_over.wav')
      stop_update
      @game_over = true
    end
    @block_update += delta
    if @block_update >= 1.0
      add_block
      @block_update = 0
    end
  end
end
