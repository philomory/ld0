module LD0
  class Woof < Chingu::GameObject
    trait :bounding_box
    trait :collision_detection
    attr_reader :direction
    def initialize(options = {})
      super
      @direction = options[:dir]
      @image = Image["woof.png"]
      @ticks_left = 61
      update
      cache_bounding_box
    end
    
    def update
      @ticks_left -= 1
      self.destroy if @ticks_left <= 0
    end
  end
end