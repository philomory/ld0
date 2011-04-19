include Gosu

module LD0
  class MainWindow < Chingu::Window
    def initialize
      super WindowWidth, WindowHeight
      self.input = {:escape => :exit}
      push_game_state(LevelState.new(:level => 1))
    end

    def update
      super
      self.caption = self.fps
    end

  end
end