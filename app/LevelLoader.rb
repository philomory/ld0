module LD0
  module LevelLoader
    WallColor = Color.argb(255,179,179,179)
    PlayerColor = Color.argb(255,0,0,0)
    DogColor = Color.argb(255,128,64,0)
    PlayerOnlyColor = Color.argb(255,102,204,255)
    DogOnlyColor = Color.argb(255,204,255,102)
    MonsterColor = Color.argb(255,0,0,128)
    GoalColor = Color.argb(255,0,255,0)
    def load_room
      @terrain = Grid.new MapTilesWide, MapTilesHigh
      #filename = "#{ROOT}/levels/level#{@level_number}.txt"
      #data = File.read(filename)
      map_image = Image["level#{@level_number}.png"]

      MapTilesHigh.times do |y|
        MapTilesWide.times do |x|
          color = map_image.get_pixel(x,y,:color_mode => :gosu)
          klass = case color
          when WallColor then Wall
          when PlayerColor then Player
          when DogColor then Dog
          when PlayerOnlyColor then PlayerOnly
          when DogOnlyColor then DogOnly
          when MonsterColor then Monster
          when GoalColor then Goal
          when Color::WHITE then nil
          else
            case color.hue
            when 0.0 then Door
            when 320.0 then Trigger
            end
          end
          x_pos = x * TileWidth
          y_pos = y * TileHeight + MapYOffset
          klass.create(:x => x_pos, :y => y_pos, :color => color) if klass
          @terrain[x,y] = klass
        end
      end
    end
  end
end