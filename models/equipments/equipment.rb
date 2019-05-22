# frozen_string_literal: true

# Equipments father class
class Equipment
  attr_reader :bonuses, :attack_points, :defense_points

  def initialize(bonuses:, attack_points:, defense_points:)
    @bonuses = bonuses
    @attack_points = attack_points
    @defense_points = defense_points
  end
end
