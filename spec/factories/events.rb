FactoryBot.define do
  factory :event do
    association :user

    title { "test_title" }
    description { "test_description" }
    address { "test_place" }
    datetime { Time.now }
  end
end
