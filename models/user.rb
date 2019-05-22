# frozen_string_literal: true

require_relative './equipments/nil_equipment'

# User model
class User
  attr_reader :weapons,
              :helmet,
              :body_armor,
              :boots,
              :gloves,
              :rings,
              :amulet,
              :life

  def initialize(equipments: {}, life:)
    assing_armor(equipments)
    assing_equipments(equipments)
    @life = life
  end

  private

  attr_writer :weapons,
              :helmet,
              :body_armor,
              :boots,
              :gloves,
              :rings,
              :amulet

  def assing_equipments(equipments)
    @amulet = equipments[:amulet] || NilEquipment.new
    @rings = equipments[:rings] || [NilEquipment.new]
    @weapons = equipments[:weapons] || [NilEquipment.new]
  end

  def assing_armor(equipments)
    @body_armor = equipments[:body_armor] || NilEquipment.new
    @boots = equipments[:boots] || NilEquipment.new
    @helmet = equipments[:helmet] || NilEquipment.new
    @gloves = equipments[:gloves] || NilEquipment.new
  end
end
