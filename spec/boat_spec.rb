require 'boat'

describe Boat do

  it "should return boat that is alive" do
    expect(subject.alive).to eq true
  end

    it "takes damage and sinks when damage = size" do

      2.times {subject.hit}
      expect(subject.sunk).to eq true

  end

  it "has a set size on being created, default 2" do

    expect(subject.size).to eq 2

  end

end
