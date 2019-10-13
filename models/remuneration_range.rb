class RemunerationRange
  include ActiveModel::Validations
  attr_accessor :min, :max

  validate :validate_positive
  validate :validate_present

  def validate_positive
    errors.add(:min, :max, message: 'should be positive') if min.to_i.negative? ||
                                                             max.to_i.negative?
  end

  def validate_present
    errors.add(:min, :max, message: 'at least one should be present') if min.to_i.zero? &&
                                                                         min.to_i.zero?
  end

  def self.create_for(min_price, max_price)
    range = RemunerationRange.new
    range.min = min_price.to_i
    range.max = max_price.to_i
    range
  end
end
