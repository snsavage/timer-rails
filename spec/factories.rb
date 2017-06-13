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
end
