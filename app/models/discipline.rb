class Discipline < ApplicationRecord
  has_many :contests

  validates_presence_of :name

  TURN_BASED_TYPE = "turn_based".freeze
  PURE_STATS_TYPE = "pure_stats".freeze

  def determine_winner(pets)
    pets = pets.map{|p| p.with_indifferent_access}
    case self.name
    when Discipline::TURN_BASED_TYPE
      winner = Discipline.turn_based_battle(pets)
    when Discipline::PURE_STATS_TYPE
      winner = Discipline.pure_stats_battle(pets)
    else
      winner = nil
    end
    return winner
  end

  def self.turn_based_battle(pets, use_blocking_chance=true)
    winner = nil
    pets_ordered = pets.sort_by{|p| [p[:speed], p[:intelligence], p[:strength]]}.reverse
    attacking_pet_index = 0
    while pets_ordered.map{|p| p[:integrity]}.min > 0
      defending_pet_index = (attacking_pet_index + 1) % pets.length
      defending_pet = pets_ordered[defending_pet_index]
      attacking_pet = pets_ordered[attacking_pet_index]
      pets_ordered[defending_pet_index][:integrity] = pets_ordered[defending_pet_index][:integrity] - damage_dealt(attacking_pet, defending_pet, use_blocking_chance)
      attacking_pet_index = defending_pet_index
    end
    winner = pets_ordered.sort_by{|p| p[:integrity]}.last
    return winner
  end

  def self.pure_stats_battle(pets)
    winner = pets.sort{|a, b| stat_quantification(a, b) }.last
  end

  def self.damage_dealt(attacking_pet, defending_pet, use_blocking_chance)
    block_score = defending_pet[:speed] + defending_pet[:intelligence]
    block_chance = 0.7 * block_score / (block_score + 20)
    if use_blocking_chance.present?
      #chance to block version
      did_block = rand(0..100) < block_chance * 100
      damage = did_block.present? ? 0 : attacking_pet[:strength] + attacking_pet[:speed]
    else
      #a damage reduction version
      damage = (attacking_pet[:strength] + attacking_pet[:speed]) * (1 - block_chance)
    end
    return damage
  end

  def self.stat_quantification(pet_1, pet_2)
    total = 0
    total += 1 if pet_1[:strength] > pet_2[:strength]
    total += 1 if pet_1[:intelligence] > pet_2[:intelligence]
    total += 1 if pet_1[:speed] > pet_2[:speed]
    total += 1 if pet_1[:integrity] > pet_2[:integrity]
    #break ties
    tiebreak_fields = ["strength", "intelligence", "speed", "integrity"]
    field = 0
    while total == 2 && field < 4
      total += 0.1 if pet_1.with_indifferent_access[tiebreak_fields[field]] > pet_2.with_indifferent_access[tiebreak_fields[field]]
      field += 1
    end
    return total
  end

end
