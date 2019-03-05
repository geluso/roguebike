class Player
  attr_accessor :xx, :yy, :facing, :speed, :hp

  def initialize(xx: 0, yy: 0)
    @xx = xx
    @yy = yy
    @facing = :EAST
    @speed = 1
    
    @hits = 0
    @hp = 10
  end

  def symbol
    ss = Geo.symbol(@facing)
    Pastel.new.yellow(ss)
  end

  def slow_down
    @speed -= 1
    if @speed < 0
      @speed = 0
    end
  end

  def speed_up
    @speed += 1
    if @speed > 10
      @speed = 10
    end
  end

  def collide(obstacle)
    @hits += 1
  end

  def damage
    @hp - @hits
  end

  def fire
    transform = Transform.new(xx: @xx, yy: @yy, facing: @facing)
    Projectile.new(transform)
  end

  def fire_mega
    t1 = Transform.new(
      xx: @xx, yy: @yy,
      facing: Geo.turn_left(@facing)
    )

    t2 = Transform.new(
      xx: @xx, yy: @yy,
      facing: @facing
    )

    t3 = Transform.new(
      xx: @xx, yy: @yy,
      facing: Geo.turn_right(@facing)
    )

    p1 = Projectile.new(t1)
    p2 = Projectile.new(t2)
    p3 = Projectile.new(t3)

    [p1, p2, p3]
  end

  def to_s
    "#{self.symbol} #{@xx} #{@yy}"
  end
end
