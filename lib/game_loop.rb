class GameLoop
  def initialize(width: 5, height: 4)
    @space = Space.new(width: width, height: height)
    @is_running = true
  end

  def run
    while @is_running
      self.display
      self.tick
    end
  end

  def display
    system("clear")
    puts @space

    prompt = "(x) quit (h) left --(j)(k)++ (l) right (space) engage"
    puts "=" * @space.grid.width * 2
    puts prompt
    
    speed = @space.player.speed
    speed_meter = "+" * speed
    puts "Speed: #{speed} #{speed_meter}"

    hp_meter = "#{@space.player.damage}/#{@space.player.hp}"
    puts "Health: #{hp_meter}"

    xx = @space.player.xx
    yy = @space.player.yy

    # puts "player: (#{xx}, #{yy})"
    # puts "asteroids: #{@space.asteroids}"
  end

  def tick
    choice = STDIN.gets.chomp
    if choice == "x"
      @is_running = false
    elsif choice == "h"
      @space.turn_left
    elsif choice == "l"
      @space.turn_right
    elsif choice == "+"
      @space.speed_up
    elsif choice == "-"
      @space.slow_down
    elsif choice == " " || choice == ""
      @space.player.speed.times do
        @space.engage
      end
    end
  end
end
