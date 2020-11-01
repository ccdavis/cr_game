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
end

