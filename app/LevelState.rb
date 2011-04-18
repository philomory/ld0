module LD0
  class LevelState < Chingu::GameState
    def initialize(options = {})
      super
      @level_number = options[:level] || 1
      load_room
    end

    
    def draw
      fill(Gosu::Color::WHITE)
      super
    end
    
    
    def load_room
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
        end
      end
    end
  end
end