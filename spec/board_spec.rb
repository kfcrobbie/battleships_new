require 'board'

describe Board do

  let (:boat) {double :boat, size: 2, direction: 'e'}

  context "Creation" do

    it { is_expected.to respond_to :boathash}

    it "create a 10x10 board of coordinates (A1, A2 etc)" do
      expect(subject.boathash.include?('C2')).to eq true
    end

  end

  context "Placing ships" do

    it 'knows when a boat is off the board' do
      expect(subject.outside_board?(boat,"J10")).to eq true
    end

    it 'will throw an error when trying to place a boat outside of board' do
      expect { subject.place(boat, "Z10") }.to raise_error 'Can\'t place boat outside the board!'
    end

    it "can place a boat on board" do
      subject.place(boat, 'C2')
      expect(subject.boathash['C2']).to eq boat
    end

    it 'allows a ship of size 2 to fill 2 spaces on the board' do
      subject.place(boat,'A10')
      expect(subject.boathash['B10']).to eq boat
    end

    it "allows a ship of size 2 to fill 2 vertical spaces if direction is 's'" do
      boat = double :boat, size: 2, direction: 's'
      subject.place(boat,'C4')
      expect(subject.boathash['C5']).to eq boat
    end

    it 'will throw an error when trying to place a boat on top of another boat' do
      subject.place(boat, "A1")
      expect { subject.place(boat, "B1") }.to raise_error 'Boat already placed there!'
    end

  end

  context "Aiming" do

    it "returns :miss when you aim at a location that doesn't have a boat" do
      expect(subject.fire_at('E2')).to eq "Miss!"
    end

    it 'checks if a boat is in the location of guess and returns hit if so' do
      subject.place(boat, 'C2')
      allow(boat).to receive :hit
      expect(subject.fire_at('C2')).to eq "Hit!"
    end


    it 'changes the value of the location you have tried to hit to "M" if there is no boat there' do
      subject.fire_at('A1')
      expect(subject.boathash['A1']).to eq 'M'
    end

    it "returns an error if a second guess is made at the same location" do
      subject.fire_at('A1')
      expect { subject.fire_at('A1')}.to raise_error 'You\'ve already guessed there!'
    end

  end

  context "Game Over" do

    it 'Announces when the game has finished' do
      allow(boat).to receive :hit
      subject.place(boat,"A1")
      subject.fire_at("A1")
      expect(subject.fire_at("B1")).to eq "All boats sunk - OPPONENT WINS!"
    end
  end
end
