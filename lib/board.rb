require_relative 'boat'

class Board
attr_accessor :boathash

  def initialize
    @boathash = Hash.new
    make_board
  end

  def place (boat, loc)
    i=0
    while i <= boat.size do
    outside_board_fail(loc)
    boat_placed_fail(loc)
    boathash[loc] = boat
    array = loc.split('')
    array[1].next!
    loc = array[0].to_s + array[1].to_s
    i += 1
    end
  end

  def guess_result(guess)
    if boathash.key?(guess)
      boat = boathash[guess]
      boat.hit unless boat == 'w'
      return :hit unless boat == 'w'
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

end


# num = x.to_s + y.to_s
