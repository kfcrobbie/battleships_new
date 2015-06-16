require_relative 'boat'

class Board
attr_accessor :boathash

  def initialize
    @boathash = Hash.new
  end

  def place (boat, loc)
    boathash[boat] = loc
  end

  def guess_result(guess)
    if boathash.value?(guess)
      boat = boathash.key(guess)
      boat.hit
      return :hit
    end
    :miss
  end

end
