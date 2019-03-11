class Projectile < Actor
  attr_accessor :is_alive

  def initialize(transform)
    @transform = transform
    @is_alive = true
  end

  def xx
    @transform.xx
  end

  def yy
    @transform.yy
  end

  def facing
    @transform.facing
  end

  def step
    @transform = Geo.step_transform(@transform)
  end

  def symbol
    "*"
  end

  def to_s
    "Projectile @ #{@transform.xx} #{@transform.yy}"
  end

  def color
    Ncurses.COLOR_PAIR(5)
  end
end
