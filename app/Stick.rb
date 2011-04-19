module LD0
  class Stick < Chingu::GameObject
    trait :bounding_box, :scale => 0.50
    trait :collision_detection
    trait :velocity
    include TerrainCollision
    
    def initialize(options ={})
      super
      @image = Image['stick.png']
      @flying = true
      @direction = options[:dir]
      v = case @direction
      when :north then [ 0,-4]
      when :south then [ 0, 4]
      when :east  then [ 4, 0]
      when :west  then [-4, 0]
      end
      self.velocity_x, self.velocity_y = *v
      self.input = {:f => :decay}
      $dog.fetch(self)
    end
    
    def flying?
      !!@flying
    end
    
    def update
      super
      if colliding_with_terrain?(@direction)
        self.velocity_x = self.velocity_y = 0
        self.x = previous_x
        self.y = previous_y
        @flying = false
        decay unless $dog.fetch_stick == self
      end
    end
    
    def decay
      self.destroy unless flying?
    end
    
  end
end