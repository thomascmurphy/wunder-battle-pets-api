class Contest < ApplicationRecord
  belongs_to :discipline

  validates_presence_of :discipline_id, :pet_1_id, :pet_2_id

  after_create :determine_winner

  def determine_winner
    BattleJob.perform_later(self)
  end

  def battle
    if self.winner_id.blank?
      require 'pets/request'
      pet_request = Pets::Request.new()
      pet_1_response = pet_request.get_pet_by_id(self.pet_1_id)
      pet_1 = pet_1_response.parsed_response
      pet_2_response = pet_request.get_pet_by_id(self.pet_2_id)
      pet_2 = pet_2_response.parsed_response
      winner = self.discipline.determine_winner([pet_1, pet_2])
      self.winner_id = winner[:id]
      self.save
    end
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

end
