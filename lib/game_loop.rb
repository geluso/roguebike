class GameLoop
  def initialize
    @space = Space.new
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
    puts "=" * prompt.length
    puts prompt

    xx = @space.player.xx
    yy = @space.player.yy

    puts "player: (#{xx}, #{yy})"
  end

  def tick
    choice = STDIN.gets.chomp
    if choice == "x"
      @is_running = false
    elsif choice == "h"
      @space.player.turn_left
    elsif choice == "l"
      @space.player.turn_right
    elsif choice == "j"
      @space.player.slow_down
    elsif choice == "k"
      @space.player.speed_up
    elsif choice == " " || choice == ""
      @space.player.engage
    end

    @space.align_player
  end
end
