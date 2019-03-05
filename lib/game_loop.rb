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
      @space.turn_left
    elsif choice == "l"
      @space.turn_right
    elsif choice == " " || choice == ""
      @space.engage
    end
  end
end
