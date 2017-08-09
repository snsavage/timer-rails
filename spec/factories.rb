FactoryGirl.define do
  factory :user do
    first_name Faker::Name.first_name
    sequence(:email) { |n| "example#{n}@example.com" }
    password "password"
  end

  factory :routine do
    sequence(:name) { |n| "Tabata #{n}" }
    times 1
    user
  end

  factory :group do
    times 1
    routine
  end

  factory :interval do
    group
    sequence(:name) { |n| "Interval #{n}" }
    duration 10
  end
end
