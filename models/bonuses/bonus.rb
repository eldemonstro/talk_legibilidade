# frozen_string_literal: true

# Bonus for equipments
class Bonus
  attr_reader :bonus_type, :multiplier

  BONUS_TYPES = %w[damage attack defense recoil].freeze

  def initialize(bonus_type:, multiplier:)
    @bonus_type = bonus_type
    @multiplier = multiplier
    raise StandardError unless BONUS_TYPES.include?(@bonus_type)
  end
end
