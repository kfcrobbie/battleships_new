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
    expect(subject.boathash.key?('I1')).to eq true
    expect(subject.boathash.key?('D7')).to eq true
  end

  it 'will throw an error when trying to place a boat outside of board' do
    expect { subject.place(boat, "Z10") }.to raise_error 'Can\'t place boat outside the board!'
  end

  it 'will throw an error when trying to place a boat on top of another boat' do
    subject.place(boat, "A1")
    expect { subject.place(boat, "A1") }.to raise_error 'Boat already placed there!'
  end

  it 'allows a ship of size 2 to fill 2 spaces on the board' do
    subject.place(boat,'C2')
    expect(subject.boathash['C3']).to eq boat
  end

  it "allows a ship of size 2 to fill 2 vertical spaces if direction is 's'" do
    boat.direction = 's'
    subject.place(boat,'C2')
    expect(subject.boathash['D2']).to eq boat

  end

  

end
