class Visibility
  attr_reader :seeing, :seen  

  def initialize
    @seeing = Hash.new(false)
    @seen = Hash.new(false)
  end 

  def key(xx, yy)
    "#{xx},#{yy}"
  end

  def see(xx, yy)
    key_ = key(xx, yy)
    @seeing[key_] = true
    @seen[key_] = true
  end

  def unsee(xx, yy)
    key_ = key(xx, yy)
    @seeing[key_] = false
  end

  def seen?(xx, yy)
    @seen[key(xx, yy)]
  end

  def seeing?(player, actor)
    xx = actor.xx
    yy = actor.yy

    distance = Geo.distance(player, actor)
    if distance < 5
      @seen[key(xx, yy)] = true
    end

    @seen[key(xx, yy)]
  end

  def unsee_all
    @seeing = Hash.new(false)
  end
end
