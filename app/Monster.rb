module LD0
  class Monster < Chingu::GameObject
    trait :bounding_box, :scale => 0.80, :debug => $DEBUG
    trait :collision_detection
    trait :velocity
    
    include TerrainCollision
    def setup
      @image = Image["monster.png"]
      self.rotation_center = :top_left
      update
      cache_bounding_box
    end
    def flee(dir)
      @direction = dir
      v = case @direction
      when :north then [ 0,-2]
      when :south then [ 0, 2]
      when :east  then [ 2, 0]
      when :west  then [-2, 0]
      end
      self.velocity = v
      puts "Flee! Go #{@direction}!"
    end
    
    def stop
      self.velocity = [0,0]
      self.x, self.y = previous_x, previous_y
      @direction = nil
    end
    
    def update
      super
      return unless @direction
      if self.colliding_with_terrain?(@direction)
        stop
      else
        self.each_collision(Wall) do |me, wall|
          stop
          break
        end
      end
        
    end
  end
end