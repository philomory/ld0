module LD0
  class Dog < Chingu::GameObject
    trait :bounding_box, :scale => 0.50
    traits :collision_detection, :velocity
    include TerrainCollision
    
    attr_accessor :fetch_stick
    def setup
      $dog = self
      @image = Image['dog.png']
      self.input = {
        :c => :come_to_player,
        :s => :stay,
        :p => :speak
      }
      self.zorder = 200
      @target_x = self.x
      @target_y = self.y
      update
      cache_bounding_box

    end
    
    def come_to_player
      unfetch
      @target_x = $player.x
      @target_y = $player.y
    end
    
    def stay
      unfetch
      @target_x = self.x
      @target_y = self.y
    end
    
    def fetch(stick)
      @fetch_stick = stick
    end
    
    def unfetch
      @fetch_stick.decay if @fetch_stick
      @fetch_stick = nil
    end
    
    def speak
      return if Woof.size.nonzero?
      Woof.create(:x => self.x     , :y => self.y - 16, :dir => :north)
      Woof.create(:x => self.x     , :y => self.y + 16, :dir => :south)
      Woof.create(:x => self.x + 16, :y => self.y     , :dir => :east)
      Woof.create(:x => self.x - 16, :y => self.y     , :dir => :west)
    end
    
    def update
      if @fetch_stick
        @target_x, @target_y = @fetch_stick.x, @fetch_stick.y
      end
      
      move_x = (@target_x <=> @x) * 2
      move_y = (@target_y <=> @y) * 2
      
      if move_x.nonzero?
        self.x += move_x
        dir = move_x > 0 ? :east : :west
        if self.colliding_with_terrain?(dir)
          self.x = previous_x
        else
          self.each_collision(Player,Monster,PlayerOnly,Door) do |me, wall|
            self.x = previous_x
            break
          end
        end
      end
      
      if move_y.nonzero?
        self.y += move_y
        dir = move_y > 0 ? :south : :north
        if self.colliding_with_terrain?(dir)
          self.y = previous_y
        else
          self.each_collision(Player,PlayerOnly,Door) do |me, wall|
            self.y = previous_y
            break
          end
        end
      end
      
      if self.x == previous_x && self.y == previous_y
        @target_x = self.x
        @target_y = self.y
      end
    end
    
    
  end
end