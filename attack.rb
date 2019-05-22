# frozen_string_literal: true

# Class that calculates an attack
class Attack
  include Math
  def attack(user, _enemy)
    dmg = 0

    user.weapons.each do |w|
      w.bonuses.each do |b|
        if b.bonus_type == 'damage'
          dmg = b.multiplier
        end
      end
    end

    dmg_is = (1..dmg).map do |d|
      w_atk_p = 0
      w_atk_m = 0
      w_atk_r = 0

      w_def_p = 0
      w_def_m = 0

      user.weapons.each do |w|
        w_atk_p += w.attack_points
        w_def_p += w.defense_points

        w.bonuses.each do |b|
          if b.bonus_type == 'attack'
            w_atk_m += b.multiplier
          elsif b.bonus_type == 'recoil'
            w_atk_r += b.multiplier
          elsif b.bonus_type == 'defense'
            w_def_m += b.multiplier
          end
        end
      end

      r_atk_p = 0
      r_atk_m = 0

      r_def_p = 0
      r_def_m = 0

      user.rings.each do |r|
        r_atk_p += r.attack_points
        r_def_p += r.defense_points

        r.bonuses.each do |b|
          if b.bonus_type == 'attack'
            r_atk_m += b.multiplier
          elsif b.bonus_type == 'defense'
            r_def_m += b.multiplier
          end
        end
      end

      h_atk_p = user.helmet.attack_points
      h_atk_m = 0

      h_def_p = user.helmet.defense_points
      h_def_m = 0

      user.helmet.bonuses.each do |b|
        if b.bonus_type == 'attack'
          h_atk_m += b.multiplier
        elsif b.bonus_type == 'defense'
          h_def_m += b.multiplier
        end
      end

      bb_atk_p = user.body_armor.attack_points
      bb_atk_m = 0

      bb_def_p = user.body_armor.defense_points
      bb_def_m = 0

      user.body_armor.bonuses.each do |b|
        if b.bonus_type == 'attack'
          bb_atk_m += b.multiplier
        elsif b.bonus_type == 'defense'
          bb_def_m += b.multiplier
        end
      end

      b_atk_p = user.boots.attack_points
      b_atk_m = 0

      b_def_p = user.boots.defense_points
      b_def_m = 0

      user.boots.bonuses.each do |b|
        if b.bonus_type == 'attack'
          b_atk_m += b.multiplier
        elsif b.bonus_type == 'defense'
          b_def_m += b.multiplier
        end
      end

      g_atk_p = user.gloves.attack_points
      g_atk_m = 0

      g_def_p = user.gloves.defense_points
      g_def_m = 0

      user.gloves.bonuses.each do |b|
        if b.bonus_type == 'attack'
          g_atk_m += b.multiplier
        elsif b.bonus_type == 'defense'
          g_def_m += b.multiplier
        end
      end

      a_atk_p = user.amulet.attack_points
      a_atk_m = 0

      a_def_p = user.amulet.defense_points
      a_def_m = 0

      user.amulet.bonuses.each do |b|
        if b.bonus_type == 'attack'
          a_atk_m += b.multiplier
        elsif b.bonus_type == 'defense'
          a_def_m += b.multiplier
        end
      end

      atk_p_sum = w_atk_p + r_atk_p + h_atk_p + bb_atk_p + b_atk_p + g_atk_p + a_atk_p
      def_p_sum = w_def_p + r_def_p + h_def_p + bb_def_p + b_def_p + g_def_p + a_def_p

      atk_m_sum = w_atk_m + r_atk_m + h_atk_m + bb_atk_m + b_atk_m + g_atk_m + a_atk_m
      def_m_sum = w_def_m + r_def_m + h_def_m + bb_def_m + b_def_m + g_def_m + a_def_m

      atk_dmg = atk_p_sum * atk_m_sum
      defense = def_p_sum * def_m_sum
      recoil = (atk_dmg * w_atk_r * ((atk_dmg / (defense + (E ** -atk_dmg))) / 100)).floor

      DamageInstance.new(atk_dmg, recoil)
    end

    dmg_is
  end
end
