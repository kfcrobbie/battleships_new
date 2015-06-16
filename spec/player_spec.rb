require 'player'

describe Player do

  it "can guess a ship's location" do
  expect(subject.guess('C2')).to eq :miss
  end

end
