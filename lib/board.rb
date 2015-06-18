require_relative 'boat'

class Board
  attr_accessor :boathash

  def initialize
    @boathash = Hash.new
    make_board
  end

  def place (boat, loc)
    i=0
    while i < boat.size do
      outside_board_fail(loc)
      boat_placed_fail(loc)
      boathash[loc] = boat
      loc = next_loc(loc,boat)
      i += 1
    end
  end

    def guess_result(guess)
      if boathash[guess].is_a?(Boat)
        boathash[guess].hit
        boathash[guess] = 'H'

        if boathash.values.include?(Boat)
          return "All boats sunk - OPPONENT WINS!"
        else
          return :hit
        end
      end
      :miss
    end

  private

  def make_board
    ('A'..'J').each do |x|
      (1..10).each do |y|
        num = x.to_s + y.to_s
        boathash[num] = 'w'
      end
    end
    boathash
  end

  def outside_board_fail(loc)
    fail 'Can\'t place boat outside the board!' unless boathash.include?(loc)
  end

  def boat_placed_fail(loc)
    fail 'Boat already placed there!' if boathash[loc].is_a?(Boat)
  end

  def next_loc(loc,boat)
    letter=loc.scan(/[A-Z]/).join
    number=loc.scan(/[0-9]/).join
    to_change = (letter if boat.direction =='e') || (number if boat.direction =='s')
    to_change.next!
    letter+number
  end

end
