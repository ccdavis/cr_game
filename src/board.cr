require "./player"
require "./location"

class Board
    getter turn : Int32
    getter players : Array(Player)
    
    def initialize(
        @players : Array(Player),
        @turn : Int32,
        @game_map : Hash(String, Location),
        @unit_definitions :  Hash(PieceType, PieceTemplate))
    end

end