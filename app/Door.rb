module LD0
  class Door < Chingu::GameObject
    trait :bounding_box
    trait :collision_detection
    attr_reader :key
    def initialize(options = {})
      super
      self.rotation_center = :top_left
      @key = options[:color].alpha #(320 - options[:color].alpha).chr
      @image = Image["door_A.png"]
      update
      cache_bounding_box
    end
  end
end