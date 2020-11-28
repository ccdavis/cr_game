require "./spec_helper"

describe CrGame do
  it "Loads a game state" do
    g = CrGame.load("./boards/game_setup.json")
    true.should eq(g.players.size>1)
    g.turn.should eq(1)
    1.should  eq(g.units.keys.count("armor"))      
  end
end
