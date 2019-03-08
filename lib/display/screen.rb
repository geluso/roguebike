class Screen
  attr_reader :width, :height, :game

  def initialize(width: 5, height: 4, game: nil)
    @width = width * 2
    @height = height
    @game = game

    Curses.init_screen
    Curses.noecho
    Curses.start_color
    Curses.use_default_colors

    Curses.init_pair(0, 0, 0)
    Curses.init_pair(1, 2, 2)

    width = width * 2
    width += 10
    height += 10

    @bwin = Curses::Window.new(height, width, 0, 0)
    @bwin.refresh
  end

  def display
    @bwin.clear
    @bwin.box("|", "=")
    
    @bwin << @game.space.to_s
    Curses.attron(1) {
      @bwin.setpos(0, 0)
      @bwin.addstr("9", )
    }

    @bwin.refresh
  end

  def getch
    @bwin.getch
  end

  def other
    system("clear")
    puts @game.space

    prompt = "(x) quit (h) left --(j)(k)++ (l) right (space) engage (f|F|FIRE) shooting"
    puts "=" * @game.space.grid.width * 2
    puts prompt
    
    puts "       Level: #{@game.level_index + 1}"

    speed = @game.space.player.speed
    speed_meter = "+" * speed
    puts "       Speed: #{speed} #{speed_meter}"

    fuel = @game.space.player.fuel
    full = @game.space.player.fuel_capacity
    fuel_meter = "#{fuel}/#{full}"

    hp_meter = "#{@game.space.player.damage}/#{@game.space.player.hp}"
    puts "      Health: #{hp_meter}"
    puts "        Fuel: #{fuel_meter}"
    puts " Turn change: #{@turn_state}"
    puts "Speed change: #{@speed_state}"

    if @error_message
      puts @error_message
    end

    # xx = @game.space.player.xx
    # yy = @game.space.player.yy

    # puts "player: (#{xx}, #{yy})"
    # puts "asteroids: #{@game.space.asteroids}"
  end

end