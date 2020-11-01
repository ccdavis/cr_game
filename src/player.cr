require "./location"
require "./piece"

class Player
    getter name : String
    getter territories : Array(Location)    
    
    def initialize(@name)
        @territories = [] of Location
    end
    
    def add_territory(t : Location)
        @territories << t
    end
    
    def remove_territory(t : Location)
        @territories = @territories.reject{|tr| tr == t}    
    end
        
    def pieces() : Array (Piece)
        @territories.map{|t| t.pieces}.flatten
    end
    
end
