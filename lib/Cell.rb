class Cell
  def initialize(value)
    # value can either be :red or :yellow
    @value = value
    @symbol = @value == :red ? "R" : "Y"
  end
end