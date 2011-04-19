module LD0
  class Wall < Chingu::GameObject
    trait :bounding_box, :debug => $DEBUG, :scale => 0.8
    trait :collision_detection

    def setup
      @image = Image["wall.png"]
      self.rotation_center = :top_left
      update
      cache_bounding_box
    end
  end
end