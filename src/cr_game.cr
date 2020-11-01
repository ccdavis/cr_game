# TODO: Write documentation for `CrGame`

require "./serialize.cr"

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

players = game_state.make_players
game_map = game_state.make_map(players)
