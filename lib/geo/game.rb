class Game
  attr_reader :space, :level_index
  
  def initialize(width:, height:)
    @width = width
    @height = height

    @space = Space.new(width: width, height: height)

    @levels = []
    @levels << @space
    @level_index = 0
  end

  def travel_down
    @level_index += 1
    if @level_index >= @levels.length
      @space = Space.new(width: @width, height: @height, player: @space.player, up: @space.waygate_down)
      @levels << @space
    else
      @space = @levels[@level_index]
    end
  end

  def travel_up
    if @level_index > 0
      @level_index -= 1
      @space = @levels[@level_index]
    end
  end
end