require "json"
require "./player"
require "./location"
   
# The properties get populated with the values from the serialized JSON.
# We will translate this data into good types
# for actual game play with the other methods in this class.
class GameState
    include JSON::Serializable
    
    @[JSON::Field(key: "players")]
    property players : Array(String) = [] of String
    
    @[JSON::Field(key: "turn")]
    property turn : Int32 = 0
    
    @[JSON::Field(key: "units")]
    property units : Hash(String,Hash(String,Int32))
    
    @[JSON::Field(key: "containers")]
    property containers : Hash(String, Hash(String,Int32))
        
    @[JSON::Field(key: "territories")]
    property territories : Hash(String, Hash(String,String))
    
    @[JSON::Field(key: "placement")]
    property placement : Hash(String, Hash(String, Int32))
    
    @[JSON::Field(key: "game_map")]
    property game_map : Hash(String, Array(String))              
    

    def make_players() : Array(Player)
        players.map{|p| Player.new(p)}            
    end
    
    def make_unit_templates() : Hash(PieceType, PieceTemplate)
        templates = {} of PieceType => PieceTemplate
        units.map do |name, stats|            
            unit =  PieceType.parse(name.capitalize)                
          
          # A piece can be a land type, water type or air
            terrain =    if stats.has_key?("land")
                TerrainType::Land
            elsif stats.has_key?("water")
                TerrainType::Water
            elsif stats.has_key?("air")
                TerrainType::Air
            else            
                TerrainType::Unknown            
            end
                                             
            templates[unit] =PieceTemplate.new(
                piece_type = unit,
                terrain_type = terrain,
                attack = stats["attack"],
                defend = stats["defend"],
                movement = stats["movement"],
                cost = stats["cost"])                
        end    
        templates    
    end
        
    def make_terrain(terrain_name) : TerrainType
        TerrainType.parse(terrain_name.capitalize)        
    end
    
    def make_map(players : Array(Player)) : Hash(String,Location)
        locations = Hash(String, Location).new
        
        territories.each do |territory_name, location|
            owner_name : String = location["owner"]
            o : Player = players.select{|p| p.name ==  owner_name}.first            
            terrain_name = location["type"]
            t = make_terrain(terrain_name)
                          
            this_location = Location.new(
                name = territory_name, 
                owner = o, 
                terrain = t,
                ipc = location["production"].to_i())
                                               
            locations[territory_name] =  this_location
        end
        
        # Now add adjacent locations
        locations.each do |territory_name, location|
            adjacent = game_map[territory_name].map{|l|  locations[l]}
            location.add_adjacent(adjacent)
        end
        puts "created #{locations.size} locations"
        locations
    end
        
    def  place_pieces(
        game_map : Hash(String, Location), 
        unit_templates : Hash(PieceType, PieceTemplate)) : Hash(String, Location)
            
            placement.each  do |name, pieces|
                location = game_map[name]
                # Each key-value represents a PieceGroup
                piece_groups = pieces.keys.map do |piece_name|
                    piece_type = PieceType.parse(piece_name)
                    PieceGroup.new(
                        unit = unit_templates[piece_type],
                        owner = location.owner,                        
                        count = pieces[piece_name])                                                                                         
                end # every piece type                                               
                location.pieces = piece_groups
            end  # every location on the map            
            game_map           
        end           
       
       # Set up a new game
        def new_board               
            players = make_players
            game_map = make_map(players)
            unit_templates = make_unit_templates
            map_with_pieces = place_pieces(game_map, unit_templates)        
        
            Board.new(players,turn,map_with_pieces, unit_templates)                
        end
       
end


