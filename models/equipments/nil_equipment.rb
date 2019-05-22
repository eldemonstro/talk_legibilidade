# frozen_string_literal: true

# Equipments father class
class NilEquipment
  attr_reader :bonuses, :attack_points, :defense_points

  def initialize
    @bonuses = []
    @attack_points = 0
    @defense_points = 0
  end
end
