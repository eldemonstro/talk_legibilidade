# frozen_string_literal: true

include Math

require 'rspec'
require_relative '../attack'

Dir[File.dirname(__FILE__) + '/../models/**/*.rb'].each { |file| require file }

describe Attack do
  it 'calculates an attack' do
    # Creating bonuses for armor
    body_armor_attack_bonus = Bonus.new(bonus_type: 'attack', multiplier: 0.1)
    body_armor_defense_bonus = Bonus.new(bonus_type: 'defense', multiplier: 0.3)
    boots_defense_bonus = Bonus.new(bonus_type: 'defense', multiplier: 0.1)
    gloves_attack_bonus = Bonus.new(bonus_type: 'attack', multiplier: 0.3)
    helmet_defense_bonus = Bonus.new(bonus_type: 'defense', multiplier: 0.2)
    helmet_attack_bonus = Bonus.new(bonus_type: 'attack', multiplier: 0.2)

    # Creating bonuses for other equipments
    amulet_attack_bonus = Bonus.new(bonus_type: 'defense', multiplier: 0.1)
    amulet_defense_bonus = Bonus.new(bonus_type: 'attack', multiplier: 0.2)
    right_ring_attack_bonus = Bonus.new(bonus_type: 'attack', multiplier: 0.3)
    left_ring_attack_bonus = Bonus.new(bonus_type: 'attack', multiplier: 0.2)
    right_weapon_damage_bonus = Bonus.new(bonus_type: 'damage', multiplier: 4)
    right_weapon_attack_bonus = Bonus.new(bonus_type: 'attack', multiplier: 2)
    left_weapon_attack_bonus = Bonus.new(bonus_type: 'attack', multiplier: 2)
    left_weapon_recoil_bonus = Bonus.new(bonus_type: 'recoil', multiplier: 0.1)

    # Creating armor
    body_armor = BodyArmor.new(bonuses: [
                                 body_armor_attack_bonus,
                                 body_armor_defense_bonus
                               ], attack_points: 50, defense_points: 200)
    gloves = Gloves.new(bonuses: [gloves_attack_bonus],
                        attack_points: 30,
                        defense_points: 30)
    boots = Boots.new(bonuses: [boots_defense_bonus],
                      attack_points: 20,
                      defense_points: 50)
    helmet = Helmet.new(bonuses: [
                          helmet_attack_bonus, helmet_defense_bonus
                        ], attack_points: 50, defense_points: 200)

    # Creating other equipments
    amulet = Amulet.new(bonuses: [
                          amulet_attack_bonus, amulet_defense_bonus
                        ], attack_points: 20, defense_points: 0)
    right_ring = Ring.new(bonuses: [
                            right_ring_attack_bonus, right_ring_attack_bonus
                          ], attack_points: 0, defense_points: 0)
    left_ring = Ring.new(bonuses: [
                           left_ring_attack_bonus, left_ring_attack_bonus
                         ], attack_points: 10, defense_points: 0)
    right_weapon = Weapon.new(bonuses: [
                                right_weapon_attack_bonus,
                                right_weapon_damage_bonus
                              ], attack_points: 500, defense_points: 0)
    left_weapon = Weapon.new(bonuses: [
                               left_weapon_attack_bonus,
                               left_weapon_recoil_bonus
                             ], attack_points: 600, defense_points: 0)

    equipments = {
      weapons: [left_weapon, right_weapon],
      helmet: helmet,
      body_armor: body_armor,
      boots: boots,
      gloves: gloves,
      rings: [left_ring, right_ring],
      amulet: amulet
    }

    equipments_ary = [
      left_weapon, right_weapon, helmet, body_armor, boots, gloves, left_ring,
      right_ring, amulet
    ]

    attack_points_sum = equipments_ary.sum(&:attack_points)
    attack_multipliers_sum = equipments_ary.inject(0) do |sum, equipment|
      sum + equipment.bonuses
                     .select { |bonus| bonus.bonus_type == 'attack' }
                     .sum(&:multiplier)
    end

    defense_points_sum = equipments_ary.sum(&:defense_points)
    defense_multipliers_sum = equipments_ary.inject(0) do |sum, equipment|
      sum + equipment.bonuses
                     .select { |bonus| bonus.bonus_type == 'defense' }
                     .sum(&:multiplier)
    end

    damage = attack_points_sum * attack_multipliers_sum
    defense = defense_points_sum * defense_multipliers_sum
    recoil = (damage * left_weapon_recoil_bonus
      .multiplier * ((damage / (defense + (E**-damage))) / 100)).floor

    attack = Attack.new
    user = User.new(equipments: equipments, life: 50_000)

    attack.attack(user).each do |damage_instance|
      expect(damage_instance.damage).to eq damage
      expect(damage_instance.recoil).to eq recoil
    end
  end
end
