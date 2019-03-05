class GameLoop
  def initialize(width: 5, height: 4)
    @space = Space.new(width: width, height: height)
    @is_running = true
    
    @turn_state = "straight"
    @speed_state = "maintain"
  end

  def run
    while @is_running
      self.display

      choice = STDIN.gets.chomp
      self.tick(choice)
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
    puts "       Speed: #{speed} #{speed_meter}"

    hp_meter = "#{@space.player.damage}/#{@space.player.hp}"
    puts "      Health: #{hp_meter}"
    puts " Turn change: #{@turn_state}"
    puts "Speed change: #{@speed_state}"

    xx = @space.player.xx
    yy = @space.player.yy

    # puts "player: (#{xx}, #{yy})"
    # puts "asteroids: #{@space.asteroids}"
  end

  def tick(choice)
    if choice == "x"
      @is_running = false
    elsif choice == "h"
      self.attempt_turn_left
    elsif choice == "l"
      self.attempt_turn_right
    elsif choice == "+"
      self.attempt_speed_up
    elsif choice == "-"
      self.attempt_slow_down
    elsif choice == " " || choice == ""
      self.engage
    end
  end

  def attempt_turn_left
    if @turn_state != "left"
      if @turn_state == "straight"
        @turn_state = "left"
      elsif @turn_state == "right"
        @turn_state = "straight"
      end
      @space.turn_left
    end
  end

  def attempt_turn_right
    if @turn_state != "right"
      if @turn_state == "straight"
        @turn_state = "right"
      elsif @turn_state == "left"
        @turn_state = "straight"
      end
      @space.turn_right
    end
  end

  def attempt_speed_up
    if @speed_state != "speedup"
      if @speed_state == "slowdown"
        @speed_state = "maintain"
      elsif @speed_state == "maintain"
        @speed_state = "speedup"
      end
      @space.speed_up
    end
  end

  def attempt_slow_down
    if @speed_state != "slowdown" && @space.player.speed > 0
      if @speed_state == "speedup"
        @speed_state = "maintain"
      elsif @speed_state == "maintain"
        @speed_state = "slowdown"
      end
      @space.slow_down
    end
  end

  def engage
    @space.player.speed.times do
      @space.engage

      @turn_state = "straight"
      @speed_state = "maintain"
    end
  end
end
