FactoryGirl.define do
  factory :arena do
    battle_type { Faker::Lorem.word }
  end
end
