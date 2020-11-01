require "./player"

enum PieceType
    Infantry
    Tank
    AAA
    Factory
    Transport
    Submarine
    Battleship
    Fighter
    Bomber
end

# The PieceTemplate is a struct instead of class so that it is copied
# for every pgroup of units owned by each player. In this way we can
# alter the attributes of pieces during game play on a player or territory
# basis according to the rules (winning a roll for 'advanced technology'
# or similar.)
struct PieceTemplate
    property(
        piece_type : PieceType,
        cost : Int32,
         movement : Int32,
         attack : Int32,
         defend : Int32
    )
    
    def    initialize(@piece_type, @cost, @movement, @attack, @defend)
    end
       
end

class Piece
    property(
        unit : PieceTemplate,
        count : Int32,
       available_moves : Int32,
        owner : Player
    )
    
    def initialize(@unit, @owner, @count = 1)        
        @available_moves = @unit.movement    
    end
      
end