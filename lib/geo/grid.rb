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

  def to_s(viz=nil, player)
    result = ""
    is_row_even = true

    @height.times do |row|
      @width.times do |col|
        distance = Geo.distance_xy(player.xx, player.yy, col, row)
        if is_row_even
          if viz.seen?(row, col) || distance < VIEW_DISTANCE
            result << "."
          else
            result << " "
          end

          result << " "
        else
          result << " "

          if viz.seen?(row, col) || distance < VIEW_DISTANCE
            result << "."
          else
            result << " "
          end
        end
      end
      result << "\n"
      is_row_even = !is_row_even 
    end

    result
  end
end
