class RemunerationRange
  attr_accessor :min, :max

  def self.create_for(min_price, max_price)
    range = RemunerationRange.new
    range.min = min_price
    range.max = max_price
    range
  end
end
