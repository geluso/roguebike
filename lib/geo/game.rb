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
      @space = Space.new(width: @width, height: @height, player: @space.player)
      @levels << @space
      @level_index += 1
  end

  def travel_up
      if @level_index > 0
        @level_index -= 1
        @space = @levels[@level_index]
      end
  end
end