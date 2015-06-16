class Boat
  attr_accessor :alive, :size

  def initialize (size = 2)
    @alive = true
    @size = size
  end

  def hit
    self.alive = false
  end

end
