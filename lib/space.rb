class Space
  attr_reader :player

  def initialize
    @grid = Grid.new(width: 5, height: 4)
    @player = Player.new(xx: 0, yy: 0)
  end

  def align_player
    if @player.xx >= @grid.width
      @player.xx = 0
      @player.yy += 1
    end

    if @player.yy >= @grid.height
      @player.yy = 0
    end
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
