class WaygateDown
  attr_reader :xx, :yy

  def initialize(xx: 0, yy:0)
    @xx = xx
    @yy = yy
  end

  def symbol
    # using color formatting messes up drawing ship
    # Pastel.new.red(">")
    ">"
  end

  def to_s
    "#{self.symbol} #{@xx} #{@yy}"
  end
end
