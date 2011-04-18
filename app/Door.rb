module LD0
  class Door < Chingu::GameObject
    trait :bounding_box
    trait :collision_detection
    def initialize(options = {})
      super
      self.rotation_center = :top_left
      @key = options[:char].upcase
      @image = Image["door_#{@key}.png"]
      update
      cache_bounding_box
    end
  end
end