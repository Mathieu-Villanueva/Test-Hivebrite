FactoryBot.define do
  factory :event do
    name { Faker::Name.name }

    trait :with_custom_attributes do
      after(:create) do |event|
        create :custom_attribute,
               customizable: event

        create :custom_attribute,
               customizable: event
      end
    end

    trait :with_empty_attributes do
      after(:create) do |event|
        create :custom_attribute,
               customizable: event,
               name: 'first',
               value: ''

        create :custom_attribute,
               customizable: event,
               name: 'second',
               value: ''
      end
    end
  end
end