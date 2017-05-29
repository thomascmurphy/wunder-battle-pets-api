require 'rails_helper'

RSpec.describe Discipline, type: :model do
  it { should have_many(:contests) }
  it { should validate_presence_of(:name) }

  let(:strong_fast_dumb_frail) {{strength: 20, speed:15, intelligence: 10, integrity: 5}}
  let(:weak_slow_smart_beefy) {{strength: 5, speed:10, intelligence: 15, integrity: 20}}

  describe 'battles' do
    it 'calculates damage properly' do
      expect(Discipline.damage_dealt(strong_fast_dumb_frail, weak_slow_smart_beefy, false).round).to eq(21)
    end

    it 'works for turn_based' do
      expect(Discipline.turn_based_battle([strong_fast_dumb_frail, weak_slow_smart_beefy], false)[:winner]).to eq(strong_fast_dumb_frail)
    end

    it 'works for pure_stats' do
      expect(Discipline.pure_stats_battle([strong_fast_dumb_frail, weak_slow_smart_beefy])[:winner]).to eq(strong_fast_dumb_frail)
    end
  end
end
