module LD0
  class ThrowWhere < Chingu::GameState
    def setup
      self.input = {
        :up => :throw_up,
        :down => :throw_down,
        :left => :throw_left,
        :right => :throw_right,
        :escape => :cancel
      }
    end
    
    def draw
      previous_game_state.draw
    end
    
    def throw_up
      toss(:north)
    end
    
    def throw_down
      toss(:south)
    end
    
    def throw_left
      toss(:west)
    end
    
    def throw_right
      toss(:east)
    end
    
    def cancel
      pop_game_state
    end
    
    def toss(dir)
      pop_game_state
      previous_game_state.throw_stick(dir)
    end
    
  end
end