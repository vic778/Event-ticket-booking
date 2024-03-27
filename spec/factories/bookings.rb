FactoryBot.define do
  factory :booking do
    user { nil }
    event { nil }
    tickets_count { 1 }
  end
end
