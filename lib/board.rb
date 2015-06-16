require_relative 'boat'

class Board
attr_accessor :boathash

  def initialize
    @boathash = Hash.new
    make_board
  end

  def place (boat, loc)
    boathash[loc] = boat
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

end


# num = x.to_s + y.to_s
