FactoryGirl.define do
  factory :discipline do
    name { Faker::Lorem.word }
    description { Faker::Lorem.word }
  end
end
