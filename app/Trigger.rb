module LD0
  class Trigger < Chingu::GameObject
    trait :bounding_box
    trait :collision_detection
    def initialize(options = {})
      super
      self.rotation_center = :top_left
      @key = options[:char].upcase
      @image = Image["trigger_#{@key}.png"]
      update
      cache_bounding_box
    end
  end
end