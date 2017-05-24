FactoryGirl.define do
  factory :contest do
    pet_1_id { Faker::Lorem.word }
    pet_2_id { Faker::Lorem.word }

    association :arena
  end
end
