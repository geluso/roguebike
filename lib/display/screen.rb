class Screen
  attr_reader :width, :height, :game
  attr_accessor :is_animated

  def initialize(width: 5, height: 4, game: nil)
    @width = width * 2
    @height = height
    @game = game

    @is_animated = false

    width = width * 2

    Ncurses.initscr
    Ncurses.start_color
    Ncurses.cbreak
    Ncurses.noecho
    Ncurses.nonl
    Ncurses.stdscr.intrflush(false)
    Ncurses.stdscr.keypad(true)

    background = Ncurses::COLOR_BLACK
    Ncurses.init_pair(1, Ncurses::COLOR_WHITE, background);
    Ncurses.init_pair(2, Ncurses::COLOR_YELLOW, background);
    Ncurses.init_pair(3, Ncurses::COLOR_CYAN, background);
    Ncurses.init_pair(4, Ncurses::COLOR_BLUE, background);
    Ncurses.init_pair(5, Ncurses::COLOR_RED, background);

    @screen = Ncurses.stdscr
    Ncurses.refresh
  end

  def getch
    Ncurses.stdscr.getch
  end

  def display
    @screen.clear
    @screen.mvaddstr(0, 0, @game.space.to_s)

    # draw all the asteroids
    @game.space.asteroids.each do |asteroid|
      draw_actor(asteroid)
    end

    # draw projectiles
    @game.space.projectiles.each do |projectile|
      draw_actor(projectile)
    end

    # then draw the player
    draw_actor(@game.space.waygate_up)
    draw_actor(@game.space.waygate_down)
    draw_actor(@game.space.player)

    hud

    @screen.refresh
  end
  
  def hud
    @screen.move(@game.space.grid.height, 0)
    prompt = "(x) quit (h) left --(j)(k)++ (l) right (space) engage (f|F|FIRE) shooting\n"
    @screen.addstr("=" * @game.space.grid.width * 2 + "\n")
    @screen.addstr(prompt)
    
    @screen.addstr("       Level: #{@game.level_index + 1}\n")

    speed = @game.space.player.speed
    speed_meter = "+" * speed
    @screen.addstr("       Speed: #{speed} #{speed_meter}\n")

    fuel = @game.space.player.fuel
    full = @game.space.player.fuel_capacity
    fuel_meter = "#{fuel}/#{full}"

    hp_meter = "#{@game.space.player.damage}/#{@game.space.player.hp}"
    @screen.addstr("      Health: #{hp_meter}\n")
    @screen.addstr("        Fuel: #{fuel_meter}\n")

    if @error_message
      puts @error_message
    end
  end

  def draw_actor(actor)
    if !@game.space.is_thing_visible?(actor)
      return
    end

    yy = actor.yy
    xx = actor.xx * 2
    if yy.odd?
      xx += 1
    end

    @screen.attrset(actor.color)
    @screen.mvaddstr(yy, xx, actor.symbol)

    # reset to default color
    @screen.attrset(Ncurses.COLOR_PAIR(1))
  end
end
