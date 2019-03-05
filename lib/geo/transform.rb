class Transform
  attr_reader :xx, :yy, :facing

  def initialize(xx:, yy:, facing:)
    @xx = xx
    @yy = yy
    @facing = facing
  end
end
