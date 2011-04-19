module LD0
  class LevelState < Chingu::GameState
    def initialize(options = {})
      super
      @level_number = options[:level] || 1
      self.input = {:f => :fetch}
      load_room
    end
    
    def draw
      fill(Gosu::Color::WHITE)
      super
    end
    
    def fetch
      cannot_throw =  Stick.all.any? {|s| s.flying? }
      push_game_state(ThrowWhere) unless cannot_throw
    end
    
    def throw_stick(dir)
      x_pos, y_pos = $player.x, $player.y
      Stick.create(:x => x_pos, :y => y_pos, :dir => dir)
    end
    
    def terrain_at(x_pos,y_pos)
      grid_x = x_pos / TileWidth
      grid_y = (y_pos - MapYOffset) / TileHeight
      @terrain[grid_x,grid_y]
    end
    
    def load_room
      @terrain = Grid.new MapTilesWide, MapTilesHigh
      filename = "#{ROOT}/levels/level#{@level_number}.txt"
      data = File.read(filename)
      data.lines.each_with_index do |line, y|
        line[0...MapTilesWide].chars.each_with_index do |char, x|
          klass = case char
          when '0' then Wall
          when '@' then Player
          when '$' then Dog
          when '=' then PlayerOnly
          when ';' then DogOnly
          when 'a' then Trigger
          when 'A' then Door
          end
          x_pos = x * TileWidth
          y_pos = y * TileHeight + MapYOffset
          klass.create(:x => x_pos, :y => y_pos, :char => char) if klass
          @terrain[x,y] = klass
        end
      end
    end
  end
end