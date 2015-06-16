class Boat
  attr_accessor :alive, :size, :direction

  def initialize (size = 2, direction = 'e')
    @alive = true
    @size = size
    @direction = direction
    @damage = 0
  end

  def hit
    @damage += 1
    if @damage == size
      self.sunk
    end
  end

  def sunk
    self.alive = false
    puts "Boat size #{size} has sunk!"
    return true

  end

end
