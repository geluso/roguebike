class Player
  attr_accessor :xx, :yy, :facing, :speed

  def initialize(xx: 0, yy: 0)
    @xx = xx
    @yy = yy
    @facing = :EAST
    @speed = 0
  end

  def symbol
    Geo.symbol(@facing)
  end

  def slow_down
  end

  def speed_up
  end
end
