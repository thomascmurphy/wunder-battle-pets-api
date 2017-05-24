class Arena < ApplicationRecord
  has_many :contests

  validates_presence_of :battle_type

  def determine_winner(pet_1, pet_2)
    return pet_1
  end

end
