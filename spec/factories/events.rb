FactoryBot.define do
  factory :event do
    name { "MyString" }
    description { "MyText" }
    location { "MyString" }
    datetime { "2024-03-27 19:31:46" }
    total_tickets { 1 }
    user { nil }
  end
end
