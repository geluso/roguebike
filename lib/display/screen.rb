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
    Ncurses.cbreak
    Ncurses.noecho
    Ncurses.nonl
    Ncurses.stdscr.intrflush(false)
    Ncurses.stdscr.keypad(true)

    @bwin = Ncurses.stdscr
    Ncurses.refresh
  end

  def getch
    Ncurses.stdscr.getch
  end

  def display
    @bwin.clear
    
    @bwin.mvaddstr(0, 0, @game.space.to_s)
    @bwin.move(@game.space.grid.height, 0)

    prompt = "(x) quit (h) left --(j)(k)++ (l) right (space) engage (f|F|FIRE) shooting\n"
    @bwin.addstr("=" * @game.space.grid.width * 2 + "\n")
    @bwin.addstr(prompt)
    
    @bwin.addstr("       Level: #{@game.level_index + 1}\n")

    speed = @game.space.player.speed
    speed_meter = "+" * speed
    @bwin.addstr("       Speed: #{speed} #{speed_meter}\n")

    fuel = @game.space.player.fuel
    full = @game.space.player.fuel_capacity
    fuel_meter = "#{fuel}/#{full}"

    hp_meter = "#{@game.space.player.damage}/#{@game.space.player.hp}"
    @bwin.addstr("      Health: #{hp_meter}\n")
    @bwin.addstr("        Fuel: #{fuel_meter}\n")

    if @error_message
      puts @error_message
    end

    @bwin.refresh
  end
end
