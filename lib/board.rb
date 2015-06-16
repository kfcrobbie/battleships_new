require_relative 'boat'

class Board
attr_accessor :boathash

  def initialize
    @boathash = Hash.new
  end

  def place (boat, loc)
    boathash[loc] = boat
  end

  def guess_result(guess)
    if boathash.key?(guess)
      boat = boathash[guess]
      boat.hit
      return :hit
    end
    :miss
  end

end
