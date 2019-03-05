class Space
  attr_reader :player, :asteroids

  def initialize(width: 5, height: 4)
    @grid = Grid.new(width: width, height: height)
    @player = Player.new(xx: 0, yy: 0)
    @asteroids = []

    self.generate_asteroids
  end

  def generate_asteroids
    grid_size = @grid.width * @grid.height

    # pick a percentage density between 18-35 percent
    density = rand(MIN_ASTEROID_DENSITY..MAX_ASTEROID_DENSITY)
    num_asteroids = (grid_size * (density.to_f / 100)).floor

    asteroids_points = Set.new
    num_asteroids.times do
      point = @grid.random_point
      asteroids_points << point
    end

    @asteroids = asteroids_points.map do |point|
      puts "new asteroid at #{point[:xx]}"
      Asteroid.new(xx: point[:xx], yy: point[:yy])
    end
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

    # draw all the asteroids
    @asteroids.each do |asteroid|
      draw_actor(grid, asteroid)
    end

    # then draw the player
    draw_actor(grid, @player)

    grid
  end

  def draw_actor(grid, actor)
    # a dot and space for each space, then a newline at the end
    cell = (@grid.width * 2 + 1) * actor.yy
    cell += actor.xx * 2

    # account for newlines by shifting over one index
    # in the string if we land on top of one
    if actor.xx != 0 && cell % (2 * @grid.width + 1) == 0
      cell += 1
    end
    
    # odd-rows are shifted right one
    if actor.yy % 2 == 1
      cell += 1
    end

    if cell >= 0 && cell < grid.length
      grid[cell] = actor.symbol
    end
  end
end
