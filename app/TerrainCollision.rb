module LD0
  module TerrainCollision
    def colliding_with_terrain?(dir)
      box = self.bounding_box
      points = case dir
      when :west then [box.topleft, box.bottomleft]
      when :east then [box.topright, box.bottomright]
      when :north then [box.topleft, box.topright]
      when :south then [box.bottomleft, box.bottomright]
      end
      
      unwalkable = points.any? do |point|
        collide_terrain_at_point?(*point)
      end
      
      return unwalkable
      
    end
    
    def collide_terrain_at_point?(x_pos,y_pos)
      @parent.terrain_at(x_pos,y_pos) == Wall
    end

  end
end