# frozen_string_literal: true

# Damage Instance model
class DamageInstance
  attr_reader :damage, :recoil

  def initialize(damage, recoil)
    @damage = damage
    @recoil = recoil
  end
end
