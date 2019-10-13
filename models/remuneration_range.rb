class RemunerationRange
  include ActiveModel::Validations
  attr_accessor :min, :max

  validates :min, presence: true, unless: :max
  validates :max, presence: true, unless: :min

  def self.create_for(min_price, max_price)
    range = RemunerationRange.new
    range.min = min_price
    range.max = max_price
    range
  end
end
