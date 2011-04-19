module LD0
  class Victory < Chingu::GameState
    def setup
      @text1 = Chingu::Text.create("You win!", :x => 320, :y => 240, :size => 80,:zorder => 500)
      @text2 = Chingu::Text.create("Press enter to play again.", :x => 320, :y => 360, :size => 20, :zorder => 500)
      self.input = {
        :enter => LevelState
      }
    end
    
    def draw
      #fill(Gosu::Color::WHITE)
      @text1.draw
      @text2.draw
      super
    end
  end
end