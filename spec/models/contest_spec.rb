require 'rails_helper'

RSpec.describe Contest, type: :model do
  it { should belong_to(:arena) }
  it { should validate_presence_of(:pet_1_id) }
  it { should validate_presence_of(:pet_2_id) }
end
