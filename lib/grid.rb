class Grid
  attr_reader :width, :height

	def initialize(width: 30, height: 10)
    if height % 2 != 0
      raise "Grid height must be even"
    end

    @width = width
    @height = height
  end

  def random_point
    xx = rand(0..(@width-1))
    yy = rand(0..(@height-1))
    {xx: xx, yy: yy}
  end

  def to_s
    line = ". " * @width + "\n"
    line += " ." * @width + "\n"
    line = line * (@height / 2)
  end
end
