class Contest < ApplicationRecord
  belongs_to :discipline

  validates_presence_of :discipline_id, :pet_1_id, :pet_2_id

  after_create :determine_winner

  def determine_winner
    BattleJob.perform_later(self)
  end

  def battle

    require 'pets/request'
    pet_request = Pets::Request.new()
    pet_1_response = pet_request.get_pet_by_id(self.pet_1_id)
    pet_1 = pet_1_response.parsed_response
    pet_2_response = pet_request.get_pet_by_id(self.pet_2_id)
    pet_2 = pet_2_response.parsed_response
    result = self.discipline.determine_winner([pet_1, pet_2])
    if self.winner_id.blank?
      winner = result[:winner]
      self.winner_id = winner[:id]
      self.save
    end
    return result
  end

  def description
    require 'pets/request'
    pet_request = Pets::Request.new()
    pet_1_response = pet_request.get_pet_by_id(self.pet_1_id)
    pet_1 = pet_1_response.parsed_response
    pet_2_response = pet_request.get_pet_by_id(self.pet_2_id)
    pet_2 = pet_2_response.parsed_response
    return {pet_1: pet_1, pet_2: pet_2}
  end

  def sync_pets (pet_1, pet_2)
    require 'pets/request'
    pet_request = Pets::Request.new()

    pet_1_response = pet_request.get_pet_by_id(self.pet_1_id).parsed_response.with_indifferent_access if self.pet_1_id.present?
    if pet_1_response.blank? || pet_1_response[:id].blank?
      pet_1_response = pet_request.create_pet(pet_1).parsed_response.with_indifferent_access
      self.pet_1_id = pet_1_response[:id]
    end

    pet_2_response = pet_request.get_pet_by_id(self.pet_2_id).parsed_response.with_indifferent_access if self.pet_2_id.present?
    if pet_2_response.blank? || pet_2_response[:id].blank?
      pet_2_response = pet_request.create_pet(pet_2).parsed_response.with_indifferent_access
      self.pet_2_id = pet_2_response[:id]
    end

    if self.changed?
      self.save
    end

  end

end
