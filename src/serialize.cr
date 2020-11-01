require "json"
require "./player"
require "./location"
   
# This is the state after parsing from JSON.
# We will translate this data into good types
# for actual game play.
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
    
    def make_terrain(terrain_name) : TerrainType
        case  terrain_name
                when "land"
                    TerrainType::Land
                when "water"
                    TerrainType::Sea
                else
                    TerrainType::Unknown
                end
    end
    
    def make_map(players : Array(Player)) : Hash(String,Location)
        locations = Hash(String, Location).new
        
        territories.each do |territory_name, location|
            owner_name : String = location["owner"]
            o : Player = players.select{|p| p.name ==  owner_name}.first            
            terrain_name = location["type"]
            t = make_terrain(terrain_name)
            if t == TerrainType::Unknown
                raise "Terrain named #{terrain_name} not known."
            end
                          
            this_location = Location.new(name = territory_name, 
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
    
    
end


