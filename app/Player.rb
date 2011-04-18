module LD0
  class Player < Chingu::GameObject
    trait :bounding_box, :scale => 0.8
    traits :collision_detection, :velocity
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
      move(0,-2)
    end

    def move_down
      move(0,2)
    end

    def move_left
      move(-2, 0)
    end

    def move_right
      move(2,0)
    end

    def move(x,y)
      self.x += x
      self.y += y
      self.each_collision(Wall,Dog,DogOnly,Door) do |me, wall|
        self.x = previous_x
        self.y = previous_y
        break
      end
    end

    def tell_dog_come_here
      puts "Come here!"
    end
    
    def tell_dog_stay
      puts "Stay!"
    end

  end
end