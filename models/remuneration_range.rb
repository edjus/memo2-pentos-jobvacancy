class RemunerationRange
  include ActiveModel::Validations
  attr_accessor :min, :max

  validate :correct_order
  validate :validate_present
  validate :validate_positive

  def self.create_for(min_price, max_price)
    range = RemunerationRange.new
    range.min = min_price.to_i
    range.max = max_price.to_i
    range
  end

  def range_message
    return "ARS$#{min}" if min == max
    return "starting from ARS$#{min}" if max.zero?
    return "up to ARS$#{max}" if min.zero?

    "between ARS$#{min} and ARS$#{max}"
  end

  private

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
end
