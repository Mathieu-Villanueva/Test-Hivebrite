FactoryBot.define do
  factory :custom_attribute do
    name { Faker::Name.name }
    value { Faker::Lorem.word }
    required { false }

    trait :required do
      required { true }
    end
  end
end