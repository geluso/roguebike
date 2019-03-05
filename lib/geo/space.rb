require 'set'

class Space
  attr_reader :player, :grid, :asteroids, :waygate_up, :waygate_down

  def initialize(width: 5, height: 4)
    @grid = Grid.new(width: width, height: height)
    @player = Player.new(xx: 0, yy: 0)

    # wait to assign waygates until after asteroids are placed
    @waygate_up = nil
    @waygate_down = nil

    @structural_points = Set.new
    @asteroids = Set.new
    @projectiles = Set.new

    self.generate_asteroids
    self.add_waygates
  end

  def generate_asteroids
    grid_size = @grid.width * @grid.height

    # pick a percentage density between 18-35 percent
    density = rand(MIN_ASTEROID_DENSITY..MAX_ASTEROID_DENSITY)
    num_asteroids = (grid_size * (density.to_f / 100)).floor

    asteroids_points = Set.new
    num_asteroids.times do
      point = @grid.random_point
      if !@structural_points.include? point
        @structural_points << point
        asteroids_points << point
      end
    end

    @asteroids = asteroids_points.map do |point|
      Asteroid.new(xx: point[:xx], yy: point[:yy])
    end
  end

  def add_waygates
    free_points = Set.new
    while free_points.length < 2
      point = @grid.random_point
      if !@structural_points.include? point
        @structural_points << point
        free_points << point
      end
    end

    free_points = free_points.collect
    @waygate_down = WaygateDown.new(free_points.next)
    @waygate_up = WaygateUp.new(free_points.next)
  end

  def turn_right
    @player.facing = Geo.turn_right(@player.facing)
  end

  def turn_left
    @player.facing = Geo.turn_left(@player.facing)
  end

  def speed_up
    @player.speed_up
  end

  def slow_down
    @player.slow_down
  end

  def engage
    new_coord = Geo.step(@player.xx, @player.yy, @player.facing)
    xx = new_coord[:xx]
    yy = new_coord[:yy]
    if self.valid?(xx: xx, yy: yy)
      @player.xx = new_coord[:xx]
      @player.yy = new_coord[:yy]
      
      self.react(@player)
    end
  end

  def fire(actor, screen)
    projectile = actor.fire
    @projectiles << projectile

    # make sure players can't enter text during animations
    screen.is_animated = true

    while projectile.is_alive
      projectile.step

      # projectile went off map
      if !valid_actor(projectile)
        projectile.is_alive = false
      end

      collision = self.collide_actor(projectile)
      if collision != nil
        @asteroids.delete(collision)
        projectile.is_alive = false
      end

      # redraw the screen every step
      screen.display
      sleep PROJECTILE_FRAME_RATE
    end

    @projectiles.delete projectile

    screen.is_animated = false
  end

  def valid?(xx: 0, yy: 0)
    collision = collide(xx, yy)
    if collision != nil
      @player.collide_actor(collision)
    end

    valid_xx_yy(xx, yy) && collision == nil
  end

  def valid_actor(actor)
    valid_xx_yy(actor.xx, actor.yy)
  end

  def valid_xx_yy(xx, yy)
    is_xx_valid = xx >= 0 && xx < @grid.width 
    is_yy_valid = yy >= 0 && yy < @grid.height 
    is_xx_valid && is_yy_valid
  end

  def collide_actor(actor)
    self.collide(actor.xx, actor.yy)
  end

  def collide(xx, yy)
    @asteroids.find do |asteroid|
      asteroid.xx == xx && asteroid.yy == yy
    end
  end

  def react(actor)
    if actor.xx == @waygate_down.xx && actor.yy == @waygate_down.yy
      puts "DOWN!!"
    end

    if actor.xx == @waygate_up.xx && actor.yy == @waygate_up.yy
      puts "up!!"
    end
  end

  def to_s
    grid = @grid.to_s

    # draw all the asteroids
    @asteroids.each do |asteroid|
      draw_actor(grid, asteroid)
    end

    # draw projectiles
    @projectiles.each do |projectile|
      draw_actor(grid, projectile)
    end

    # then draw the player
    draw_actor(grid, @waygate_up)
    draw_actor(grid, @waygate_down)
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
