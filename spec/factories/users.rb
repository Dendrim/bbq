FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@test.test" }
    password { '123123' }
    password_confirmation { '123123' }
  end
end
