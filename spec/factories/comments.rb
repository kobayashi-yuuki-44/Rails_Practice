FactoryBot.define do
  factory :comment do
    body { "MyText" }
    user { nil }
    board { nil }
  end
end
