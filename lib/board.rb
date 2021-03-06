require_relative 'boat'

class Board
  attr_accessor :boathash

  def initialize
    @boathash = Hash.new
    make_board
  end

  def place (boat, loc)
    raise 'Can\'t place boat outside the board!' if outside_board?(boat,loc)
    raise 'Boat already placed there!' if location_occupied?(boat,loc)
    all_boat_positions(boat,loc).each {|position| boathash[position]=boat}
  end

  def fire_at(guess)
    what_is_there = boathash[guess]

    raise 'You\'ve already guessed there!' if what_is_there == 'H' || what_is_there == 'M'
    if what_is_there == 'w'
      boathash[guess]='M'
      "Miss!"
    else
      boathash[guess].hit
      boathash[guess]='H'
      all_boats_sunk? ? announces_end_of_game : "Hit!"
    end
  end

  def outside_board?(boat,loc)
    # The boat is outside the board if it's end location is not on the board
    !boathash.keys.include?(end_location_of_boat(boat,loc))
  end

  def location_occupied?(boat,loc)
    all_boat_positions(boat,loc).map {|position| !["w","M"].include?(boathash[position])}.any?
  end

  private

  def all_boat_positions (boat,loc)
    boats_positions = [loc]
    (boat.size-1).times do
      boats_positions << next_loc(boat,loc)
      loc=next_loc(boat,loc)
    end
    boats_positions
  end

  def make_board
    array_of_locations = ((("A".."J").to_a).product((1..10).to_a)).map{|el| el[0] + el[1].to_s}
    array_of_locations.each {|loc| boathash[loc]='w'}
  end


  def end_location_of_boat(boat, loc)
    all_boat_positions(boat,loc)[-1]
  end


  def next_loc(boat, loc)
    letter=loc.scan(/[A-Z]/).join
    number=loc.scan(/[0-9]/).join
    to_change = (letter if boat.direction =='e') || (number if boat.direction =='s')
    to_change.next!
    letter+number
  end

  def all_boats_sunk?
    (boathash.values.uniq-['w','H','M']).empty?
  end

  def announces_end_of_game
    "All boats sunk - OPPONENT WINS!"
  end
end
