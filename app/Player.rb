module LD0
  class Player < Chingu::GameObject
    trait :bounding_box, :scale => 0.8, :debug => $DEBUG
    traits :collision_detection
    trait :velocity, :apply => false
    include TerrainCollision
    def setup
      $player = self
      @image = Image["player.png"]
      self.input = {
        :holding_left => :move_left,
        :holding_right => :move_right,
        :holding_up => :move_up,
        :holding_down => :move_down,
        :c => :tell_dog_come_here,
        :s => :tell_dog_stay
      }
      update
      cache_bounding_box
    end

    def move_up
      move(0,-2,:north)
    end

    def move_down
      move(0,2,:south)
    end

    def move_left
      move(-2, 0,:west)
    end

    def move_right
      move(2,0,:east)
    end

    def move(x,y,dir)
      self.x += x
      self.y += y
      if self.colliding_with_terrain?(dir)
        self.revert_position
      else
        self.each_collision(Dog,DogOnly,Door) do |me, wall|
          self.revert_position
          break
        end
      end
    end

    def revert_position
      self.x = previous_x
      self.y = previous_y
    end

    def tell_dog_come_here
      puts "Come here!"
    end
    
    def tell_dog_stay
      puts "Stay!"
    end

  end
end