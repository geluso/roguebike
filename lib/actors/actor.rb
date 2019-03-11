class Actor
  attr_accessor :xx, :yy, :transform

  def initialize(xx: 0, yy: 0)
    @xx = xx
    @yy = yy
  end

  def symbol
    "?"
  end

  def color
    Ncurses.COLOR_PAIR(1)
  end

  def to_s
    "?"
  end
end