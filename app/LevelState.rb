module LD0
  class LevelState < Chingu::GameState
    include LevelLoader
    def initialize(options = {})
      super
      @level_number = options[:level] || 1
      self.input = {:f => :fetch}
      load_room
    end
    
    def draw
      fill(Gosu::Color::WHITE)
      super
    end
    
    def update
      super
      check_triggers
      check_goal
    end
    
    def check_triggers
      p_triggers = []
      d_triggers = []
      $player.each_collision(Trigger) do |player,trigger|
        p_triggers << trigger.key
      end
      $dog.each_collision(Trigger) do |dog,trigger|
        d_triggers << trigger.key if p_triggers.include?(trigger.key)
      end
      Door.destroy_if {|door| d_triggers.include?(door.key)}
      Woof.each_collision(Monster) do |woof, monster|
        monster.flee(woof.direction)
      end
    end
    
    def check_goal
      p_goal = d_goal = false
      $player.each_collision(Goal) {|*_| p_goal = true; break}
      $dog.each_collision(Goal) {|*_| d_goal = true; break}
      win if p_goal && d_goal
    end
    
    def win
      switch_game_state(Victory)
    end
    
    def fetch
      cannot_throw =  Stick.all.any? {|s| s.flying? }
      push_game_state(ThrowWhere) unless cannot_throw
    end
    
    def throw_stick(dir)
      x_pos, y_pos = $player.x, $player.y
      Stick.create(:x => x_pos, :y => y_pos, :dir => dir)
    end
    
    def terrain_at(x_pos,y_pos)
      grid_x = x_pos / TileWidth
      grid_y = (y_pos - MapYOffset) / TileHeight
      @terrain[grid_x,grid_y]
    end
    
  end
end