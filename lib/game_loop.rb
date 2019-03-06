class GameLoop
  attr_writer :is_animated

  def initialize(width: 5, height: 4)
    @game = Game.new(width: width, height: height)
    @is_running = true
    
    @has_fired = false
    @turn_state = "straight"
    @speed_state = "maintain"

    @is_animated = false
    @error_message = nil
  end

  def run
    while @is_running
      self.display

      if !@is_animated
        choice = STDIN.gets.chomp
        self.tick(choice)
      end
    end
  end

  def display
    system("clear")
    puts @game.space

    prompt = "(x) quit (h) left --(j)(k)++ (l) right (space) engage (f|F|FIRE) shooting"
    puts "=" * @game.space.grid.width * 2
    puts prompt
    
    puts "       Level: #{@game.level_index}"

    speed = @game.space.player.speed
    speed_meter = "+" * speed
    puts "       Speed: #{speed} #{speed_meter}"

    hp_meter = "#{@game.space.player.damage}/#{@game.space.player.hp}"
    puts "      Health: #{hp_meter}"
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
    elsif choice == "f"
      self.fire
    elsif choice == "F"
      self.fire_mega
    elsif choice == "FIRE"
      self.fire_ultra
    elsif choice == " " || choice == ""
      self.engage
    elsif choice == "t"
      self.force_up
    elsif choice == "b"
      self.force_down
    elsif choice == "999"
      self.inifinite_sensors 
    else
      @error_message = nil
    end
  end

  def attempt_turn_left
    if @turn_state == "left" && IS_TURNING_RESTRICTED
      @error_message = "Already turned left."
    else
      if @turn_state == "straight"
        @turn_state = "left"
      elsif @turn_state == "right"
        @turn_state = "straight"
      end
      @game.space.turn_left
    end
  end

  def attempt_turn_right
    if @turn_state == "right" && IS_TURNING_RESTRICTED
      @error_message = "Already turned right."
    else
      if @turn_state == "straight"
        @turn_state = "right"
      elsif @turn_state == "left"
        @turn_state = "straight"
      end
      @game.space.turn_right
    end
  end

  def attempt_speed_up
    if @speed_state == "speedup" && IS_SPEED_RESTRICTED
      @error_message = "Already sped up."
    else
      if @speed_state == "slowdown"
        @speed_state = "maintain"
      elsif @speed_state == "maintain"
        @speed_state = "speedup"
      end
      @game.space.speed_up
    end
  end

  def attempt_slow_down
    if @speed_state == "slowdown" && IS_SPEED_RESTRICTED
      @error_message = "Already slowed down."
    elsif @game.space.player.speed <= 0
      @error_message = "Speed already at zero."
    else
      if @speed_state == "speedup"
        @speed_state = "maintain"
      elsif @speed_state == "maintain"
        @speed_state = "slowdown"
      end
      @game.space.slow_down
    end
  end

  def fire
    if @has_fired && IS_FIRING_RESTRICTED
      @error_message = "Already fired."
    else
      @has_fired = true
      projectile = @game.space.player.fire
      @game.space.fire(projectile)
      @game.space.animate_projectiles(self)
    end
  end

  def fire_mega
    if @has_fired && IS_FIRING_RESTRICTED
      @error_message = "Already fired."
    else
      @has_fired = true
      @game.space.player.fire_mega.each do |projectile|
        @game.space.fire(projectile)
      end
      @game.space.animate_projectiles(self)
    end
  end

  def fire_ultra
    if @has_fired && IS_FIRING_RESTRICTED
      @error_message = "Already fired."
    else
      @has_fired = true
      @game.space.player.fire_ultra.each do |projectile|
        @game.space.fire(projectile)
      end
      @game.space.animate_projectiles(self)
    end
  end

  def engage
    @game.space.player.speed.times do
      @game.space.engage

      @has_fired = false
      @turn_state = "straight"
      @speed_state = "maintain"

      moved_through_waygate = self.handle_waygate

      if !CONTINUE_MOVING_THROUGH_WAYGATE
        # stop iterating through .times
        break
      end
    end
  end

  def handle_waygate
    moved_through_waygate = false

    if @game.space.is_travelling_up || @game.space.is_travelling_down
      moved_through_waygate = true
      if @game.space.is_travelling_up
        @game.space.reset_waygate_state
        @game.travel_up
      else @game.space.is_travelling_down
        @game.space.reset_waygate_state
        @game.travel_down
      end
    end

    false
  end

  def force_up
    @game.travel_up
  end

  def force_down
    @game.travel_down
  end

  def inifinite_sensors
    @game.space.player.sensor_range = Float::INFINITY
  end
end
