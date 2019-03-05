class Grid
  attr_reader :width, :height

	def initialize(width: 30, height: 10)
    if height % 2 != 0
      raise "Grid height must be even"
    end

    @width = width
    @height = height
  end

  def to_s
    line = ". " * @width + "\n"
    line += " ." * @width + "\n"
    line = line * (@height / 2)
  end
end
