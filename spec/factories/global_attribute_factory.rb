FactoryBot.define do
  factory :global_attribute do
    name { Faker::Name.name }
    required { false }
    active { true }

    trait :required do
      required { true }
    end
  end
end