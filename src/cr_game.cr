# TODO: Write documentation for `CrGame`

require "./serialize.cr"
require "./board.cr"

module CrGame
  VERSION = "0.1.0"

  def self.load(board_file : String) : GameState
        json_text = File.read(board_file)
        puts "Loaded game setup..."
        game = GameState.from_json(json_text)
        puts "Game-state initialized..."
        game
    end      
    
end

game_state = CrGame.load("./boards/game_setup.json")   
board = game_state.new_board

