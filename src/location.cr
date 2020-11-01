require "./player"
require "./piece"

enum TerrainType
    Land
    Sea
end

class Location
    property(        
        owner : Player,
        pieces : Array(Piece)  = [] of Piece
    )
    
    getter name : String
    getter ipc : Int32
    getter terrain : TerrainType
    getter next_to : Array(Location) = [] of Location
        
    def initialize(@name : String, @owner : Player, @terrain : TerrainType, @ipc : Int32, @next_to : Array(Location))        
    end
    
    def change_owner(owner : Player)
        @owner.remove_territory(self)
        @owner = owner        
    end
    
    def add_adjacent(location : Location)
        @next_to << location
    end
    
    
end