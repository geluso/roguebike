class Space
  attr_reader :player

  def initialize(width: 5, height: 4)
    @grid = Grid.new(width: width, height: height)
    @player = Player.new(xx: 0, yy: 0)
  end

  def turn_right
    @player.facing = Geo.turn_right(@player.facing)
  end

  def turn_left
    @player.facing = Geo.turn_left(@player.facing)
  end

  def engage
    new_coord = Geo.step(@player.xx, @player.yy, @player.facing)
    if self.valid?(new_coord)
      @player.xx = new_coord[:xx]
      @player.yy = new_coord[:yy]
    end
  end

  def valid?(xx: 0, yy: 0)
    is_x_valid = xx >= 0 && xx < @grid.width 
    is_y_valid = yy >= 0 && yy < @grid.height 
    is_x_valid && is_y_valid
  end

  def to_s
    grid = @grid.to_s

    # a dot and space for each space, then a newline at the end
    cell = (@grid.width * 2 + 1) * @player.yy
    cell += @player.xx * 2
    if @player.xx != 0 && cell % (2 * @grid.width + 1) == 0
      cell += 1
    end
    
    if @player.yy % 2 == 1
      cell += 1
    end

    grid[cell] = @player.symbol
    grid
  end
end
