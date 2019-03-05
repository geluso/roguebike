class Player
  attr_accessor :xx, :yy, :facing, :speed

  def initialize(xx: 0, yy: 0)
    @xx = xx
    @yy = yy
    @facing = :EAST
    @speed = 0
  end

  def symbol
    ss = Geo.symbol(@facing)
    Pastel.new.yellow(ss)
  end

  def slow_down
  end

  def speed_up
  end

  def to_s
    "#{self.symbol} #{@xx} #{@yy}"
  end
end
