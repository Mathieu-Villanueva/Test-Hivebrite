FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    admin { false }

    trait :admin do
      admin { true }
    end

    trait :with_custom_attributes do
      after(:create) do |user|
        create :custom_attribute,
               customizable: user

        create :custom_attribute,
               customizable: user
      end
    end
  end
end