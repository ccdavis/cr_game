require "./player"
require "./piece"

enum TerrainType
    Land
    Water
    Unknown
end

class Location
    property(        
        owner : Player,
        pieces : Array(PieceGroup)  = [] of PieceGroup
    )
    
    getter name : String
    getter ipc : Int32
    getter terrain : TerrainType
    getter next_to : Array(Location) = [] of Location
        
    def initialize(@name : String, @owner : Player, @terrain : TerrainType, @ipc : Int32)
    end
    
    def change_owner(owner : Player)
        @owner.remove_territory(self)
        @owner = owner        
    end
    
    def add_adjacent(location : Location)
        @next_to << location
    end
    
    def add_adjacent(adj : Array(Location))
        @next_to += adj
    end
    
    
    
    
end
