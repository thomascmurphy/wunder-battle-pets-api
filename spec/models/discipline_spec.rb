require 'rails_helper'

RSpec.describe Discipline, type: :model do
  it { should have_many(:contests) }
  it { should validate_presence_of(:name) }
end
