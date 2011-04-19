module LD0
  class Goal < Chingu::GameObject
    traits :bounding_box, :collision_detection
    def setup
      @image = Image["goal.png"]
      self.rotation_center = :top_left
      update
      cache_bounding_box
    end
  end
end