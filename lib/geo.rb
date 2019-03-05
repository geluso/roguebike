class Geo
  def self.symbol(facing)
    if facing == :EAST
      return "→"
    elsif facing == :WEST
      return "←"
    elsif facing == :NORTH_EAST
      return "↗"
    elsif facing == :NORTH_WEST
      return "↖"
    elsif facing == :SOUTH_EAST
      return "↘"
    elsif facing == :SOUTH_WEST
      return "↙"
    end
  end

  def self.turn_right(direction)
    if direction == :NORTH_EAST
      direction = :EAST
    elsif direction == :EAST
      direction = :SOUTH_EAST
    elsif direction == :SOUTH_EAST
      direction = :SOUTH_WEST
    elsif direction == :SOUTH_WEST
      direction = :WEST
    elsif direction == :WEST
      direction = :NORTH_WEST
    else
      direction = :NORTH_EAST
    end
  end

  def self.turn_left(direction)
    if direction == :NORTH_EAST
      direction = :NORTH_WEST
    elsif direction == :NORTH_WEST
      direction = :WEST
    elsif direction == :WEST
      direction = :SOUTH_WEST
    elsif direction == :SOUTH_WEST
      direction = :SOUTH_EAST
    elsif direction == :SOUTH_EAST
      direction = :EAST
    else
      direction = :NORTH_EAST
    end
  end

  def self.step(xx, yy, direction)
    if direction == :WEST
      xx -= 1
    elsif direction == :EAST
      xx += 1
    elsif direction == :NORTH_EAST
      if yy % 2 == 1
        xx += 1
      end
      yy -= 1
    elsif direction == :NORTH_WEST
      if yy % 2 == 0
        xx -= 1
      end
      yy -= 1
    elsif direction == :SOUTH_EAST
      if yy % 2 == 1
        xx += 1
      end
      yy += 1
    elsif direction == :SOUTH_WEST
      if yy % 2 == 0
        xx -= 1
      end
      yy += 1
    end

    {xx: xx, yy: yy}
  end
end
