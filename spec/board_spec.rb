require 'board'

describe Board do

  let (:boat) {Boat.new}

  it { is_expected.to respond_to :boathash}

  it "can place a boat into it's hash" do
    subject.place(boat, 'C2')
    expect(subject.boathash.include?('C2')).to eq true
  end

  it "can pass a location for the boat into the hash too" do

    subject.place(boat, 'C2')
    expect(subject.boathash['C2']).to eq boat

  end

  it "can allow a guess and return with hit or miss" do
    expect(subject.guess_result('E2')).to eq :miss
  end

  it 'checks if a boat is in the location of guess and returns hit if so' do
    subject.place(boat, 'C2')
    expect(subject.guess_result('C2')).to eq :hit

  end

  it 'creates a 10 x 10 hash' do
    expect(boathash.key?('I1')).to eq true
    expect(boathash.key?('D7')).to eq true
  end

end
