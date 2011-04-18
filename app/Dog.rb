module LD0
  class Dog < Chingu::GameObject
    trait :bounding_box, :scale => 0.50
    traits :collision_detection, :velocity
    def setup
      $dog = self
      @image = Image['dog.png']
      self.input = {
        :c => :come_to_player,
        :s => :stay
      }
      @target_x = self.x
      @target_y = self.y
      update
      cache_bounding_box

    end
    
    def come_to_player
      @target_x = $player.x
      @target_y = $player.y
    end
    
    def stay
      @target_x = self.x
      @target_y = self.y
    end
    
    def update
      move_x = (@target_x <=> @x) * 2
      move_y = (@target_y <=> @y) * 2
      if move_x.nonzero?
        self.x += move_x
        self.each_collision(Wall,Player,PlayerOnly,Door) do |me, wall|
          self.x = previous_x
          break
        end
      end
      if move_y.nonzero?
        self.y += move_y
        self.each_collision(Wall,Player,PlayerOnly,Door) do |me, wall|
          self.y = previous_y
          break
        end
      end
      if self.x == previous_x && self.y == previous_y
        @target_x = self.x
        @target_y = self.y
      end
    end
    
    
  end
end