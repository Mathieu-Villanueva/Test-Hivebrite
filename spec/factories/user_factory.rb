FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    admin { false }

    trait :admin do
      admin { true }
    end
  end
end