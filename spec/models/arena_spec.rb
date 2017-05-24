require 'rails_helper'

RSpec.describe Arena, type: :model do
  it { should have_many(:contests) }
  it { should validate_presence_of(:battle_type) }
end
