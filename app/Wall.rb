module LD0
  class Wall < Chingu::GameObject
    trait :bounding_box
    trait :collision_detection

    def setup
      @image = Image["wall.png"]
      self.rotation_center = :top_left
      update
      cache_bounding_box
    end
  end
end