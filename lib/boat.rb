class Boat
  attr_accessor :alive, :size, :direction

  def initialize (size = 2, direction = 'e')
    @alive = true
    @size = size
    @direction = direction
  end

  def hit
    self.alive = false
  end

end
