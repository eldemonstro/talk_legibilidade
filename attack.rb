# frozen_string_literal: true

# Class that calculates an attack
class Attack
  include Math

  # Method to calculate an attack
  def attack(user)
    # Variable to see how many damage instances will be
    damage_instances_count = 0

    # Search within weapons for damage bonus
    user.weapons.each do |weapon|
      weapon.bonuses.each do |bonus|
        if bonus.bonus_type == 'damage'
          damage_instances_count = bonus.multiplier
        end
      end
    end

    # For each damage bonus we will calculate the attack again
    damage_instances = (1..damage_instances_count).map do
      # Values from weapons
      weapon_attack_points = 0
      weapon_attack_modifiers = 0
      weapon_attack_recoil_modifier = 0

      weapon_defense_points = 0
      weapon_defense_modifiers = 0

      # Finding bonuses and adding to the list
      user.weapons.each do |weapon|
        weapon_attack_points += weapon.attack_points
        weapon_defense_points += weapon.defense_points

        weapon.bonuses.each do |bonus|
          if bonus.bonus_type == 'attack'
            weapon_attack_modifiers += bonus.multiplier
          elsif bonus.bonus_type == 'recoil'
            weapon_attack_recoil_modifier += bonus.multiplier
          elsif bonus.bonus_type == 'defense'
            weapon_defense_modifiers += bonus.multiplier
          end
        end
      end

      # Values from rings
      rings_attack_points = 0
      rings_attack_modifiers = 0

      rings_defense_points = 0
      rings_defense_modifiers = 0

      # Finding bonuses and adding to the list
      user.rings.each do |ring|
        rings_attack_points += ring.attack_points
        rings_defense_points += ring.defense_points

        ring.bonuses.each do |bonus|
          if bonus.bonus_type == 'attack'
            rings_attack_modifiers += bonus.multiplier
          elsif bonus.bonus_type == 'defense'
            rings_defense_modifiers += bonus.multiplier
          end
        end
      end

      # Values from helmets
      helmet_attack_points = user.helmet.attack_points
      helmet_attack_modifiers = 0

      helmet_defense_points = user.helmet.defense_points
      helmet_defense_modifiers = 0

      # Finding bonuses and adding to the list
      user.helmet.bonuses.each do |bonus|
        if bonus.bonus_type == 'attack'
          helmet_attack_modifiers += bonus.multiplier
        elsif bonus.bonus_type == 'defense'
          helmet_defense_modifiers += bonus.multiplier
        end
      end

      # Values from body armor
      body_armor_attack_points = user.body_armor.attack_points
      body_armor_attack_modifiers = 0

      body_armor_defense_points = user.body_armor.defense_points
      body_armor_defense_modifiers = 0

      # Finding bonuses and adding to the list
      user.body_armor.bonuses.each do |bonus|
        if bonus.bonus_type == 'attack'
          body_armor_attack_modifiers += bonus.multiplier
        elsif bonus.bonus_type == 'defense'
          body_armor_defense_modifiers += bonus.multiplier
        end
      end

      # Values from boots
      boots_attack_points = user.boots.attack_points
      boots_attack_modifiers = 0

      boots_defense_points = user.boots.defense_points
      boots_defense_modifiers = 0

      # Finding bonuses and adding to the list
      user.boots.bonuses.each do |bonus|
        if bonus.bonus_type == 'attack'
          boots_attack_modifiers += bonus.multiplier
        elsif bonus.bonus_type == 'defense'
          boots_defense_modifiers += bonus.multiplier
        end
      end

      # Values from gloves
      gloves_attack_points = user.gloves.attack_points
      gloves_attack_modifiers = 0

      gloves_defense_points = user.gloves.defense_points
      gloves_defense_modifiers = 0

      # Finding bonuses and adding to the list
      user.gloves.bonuses.each do |bonus|
        if bonus.bonus_type == 'attack'
          gloves_attack_modifiers += bonus.multiplier
        elsif bonus.bonus_type == 'defense'
          gloves_defense_modifiers += bonus.multiplier
        end
      end

      # Values from amulet
      amulet_attack_points = user.amulet.attack_points
      amulet_attack_modifiers = 0

      amulet_defense_points = user.amulet.defense_points
      amulet_defense_modifiers = 0

      # Finding bonuses and adding to the list
      user.amulet.bonuses.each do |bonus|
        if bonus.bonus_type == 'attack'
          amulet_attack_modifiers += bonus.multiplier
        elsif bonus.bonus_type == 'defense'
          amulet_defense_modifiers += bonus.multiplier
        end
      end

      # Making a sum of all the points from the itens
      attack_points_sum = weapon_attack_points + rings_attack_points + helmet_attack_points + body_armor_attack_points + boots_attack_points + gloves_attack_points + amulet_attack_points
      defense_points_sum = weapon_defense_points + rings_defense_points + helmet_defense_points + body_armor_defense_points + boots_defense_points + gloves_defense_points + amulet_defense_points

      # Making a sum of all the bonuses from the items
      attack_modifiers_sum = weapon_attack_modifiers + rings_attack_modifiers + helmet_attack_modifiers + body_armor_attack_modifiers + boots_attack_modifiers + gloves_attack_modifiers + amulet_attack_modifiers
      defense_modifiers_sum = weapon_defense_modifiers + rings_defense_modifiers + helmet_defense_modifiers + body_armor_defense_modifiers + boots_defense_modifiers + gloves_defense_modifiers + amulet_defense_modifiers

      # Calculating damage, defense and recoil
      attack_total = attack_points_sum * attack_modifiers_sum
      defense_total = defense_points_sum * defense_modifiers_sum
      recoil_total = (attack_total * weapon_attack_recoil_modifier * ((attack_total / (defense_total + (E ** -attack_total))) / 100)).floor

      # Creating a new DamageInstance
      DamageInstance.new(attack_total, recoil_total)
    end

    # Returning damage instances
    damage_instances
  end
end
