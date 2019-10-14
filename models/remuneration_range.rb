class RemunerationRange
  include ActiveModel::Validations
  attr_accessor :min, :max

  validate :correct_order
  validate :validate_present
  validate :validate_positive

  def validate_positive
    errors.add(:min, :max, message: 'should be positive') if min.negative? ||
                                                             max.negative?
  end

  def validate_present
    errors.add(:min, :max, message: 'at least one should be present') if min.zero? &&
                                                                         max.zero?
  end

  def correct_order
    if (min >
                                                                               max) &&
       (min != 0 &&
       max != 0)
      errors.add(:min,
                 :max,
                 message: 'inital value should be less or eq than end value')
    end
  end

  def self.create_for(min_price, max_price)
    range = RemunerationRange.new
    range.min = min_price.to_i
    range.max = max_price.to_i
    range
  end

  def range_message
    return min.to_s if min == max
    return "starting from #{min}" if max.zero?
    return "up to #{max}" if min.zero?

    "between #{min} and #{max}"
  end
end
