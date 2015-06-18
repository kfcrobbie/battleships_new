require_relative 'boat'

class Board
  attr_accessor :boathash

  def initialize
    @boathash = Hash.new
    make_board
  end

  def place (boat, loc)
    raise 'Can\'t place boat outside the board!' if outside_board?(boat,loc)
    boathash[loc]=boat
    (boat.size-1).times{boathash[next_loc(boat,loc)]=boat}
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

  # private

  def make_board
    array_of_locations = ((("A".."J").to_a).product((1..10).to_a)).map{|el| el[0] + el[1].to_s}
    array_of_locations.each {|loc| boathash[loc]='w'}
  end

  def outside_board?(boat,loc)
    # The boat is outside the board if it's end location is not on the board
    !boathash.keys.include?(end_location_of_boat(boat,loc))
  end

  def end_location_of_boat(boat, loc)
    final_loc= ""
    (boat.size-1).times do
      final_loc=next_loc(boat,loc)
      loc=final_loc
    end
    final_loc
  end



  def next_loc(boat, loc)
    letter=loc.scan(/[A-Z]/).join
    number=loc.scan(/[0-9]/).join
    to_change = (letter if boat.direction =='e') || (number if boat.direction =='s')
    to_change.next!
    letter+number
  end

end
