require "./spec_helper"

describe CrGame do
  it "works" do
    g = CrGame.load("./boards/game_setup.json")
    true.should eq(g.players.size>1)
    
  end
end
