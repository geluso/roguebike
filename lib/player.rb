class Player
  attr_accessor :xx, :yy

  def initialize(xx: 0, yy: 0)
    @xx = xx
    @yy = yy
    @facing = :EAST
  end

  def symbol
    if @facing == :EAST
      return "→"
    elsif @facing == :WEST
      return "←"
    elsif @facing == :NORTH_EAST
      return "↗"
    elsif @facing == :NORTH_WEST
      return "↖"
    elsif @facing == :SOUTH_EAST
      return "↘"
    elsif @facing == :SOUTH_WEST
      return "↙"
    end
  end

  def turn_right
    if @facing == :NORTH_EAST
      @facing = :EAST
    elsif @facing == :EAST
      @facing = :SOUTH_EAST
    elsif @facing == :SOUTH_EAST
      @facing = :SOUTH_WEST
    elsif @facing == :SOUTH_WEST
      @facing = :WEST
    elsif @facing == :WEST
      @facing = :NORTH_WEST
    else
      @facing = :NORTH_EAST
    end
  end

  def turn_left
    if @facing == :NORTH_EAST
      @facing = :NORTH_WEST
    elsif @facing == :NORTH_WEST
      @facing = :WEST
    elsif @facing == :WEST
      @facing = :SOUTH_WEST
    elsif @facing == :SOUTH_WEST
      @facing = :SOUTH_EAST
    elsif @facing == :SOUTH_EAST
      @facing = :EAST
    else
      @facing = :NORTH_EAST
    end
  end

  def slow_down
  end

  def speed_up
  end

  def engage
    if @facing == :WEST
      @xx -= 1
    elsif @facing == :EAST
      @xx += 1
    elsif @facing == :NORTH_EAST
      if @yy % 2 == 1
        @xx += 1
      end
      @yy -= 1
    elsif @facing == :NORTH_WEST
      if @yy % 2 == 1
        @xx -= 1
      end
      @yy -= 1
    elsif @facing == :SOUTH_EAST
      if @xx % 2 == 1
        @xx += 1
      end
      @yy += 1
    elsif @facing == :SOUTH_WEST
      if @xx % 2 == 0
        @xx -= 1
      end
      @yy += 1
    end
  end
end
