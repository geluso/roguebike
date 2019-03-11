class Asteroid < Actor
  attr_reader :xx, :yy

  def initialize(xx: 0, yy:0)
    @xx = xx
    @yy = yy
  end

  def symbol
    "#"
  end

  def to_s
    "#{self.symbol} #{@xx} #{@yy}"
  end
end
