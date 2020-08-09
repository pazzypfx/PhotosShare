FactoryBot.define do
  factory :place do
    name { Faker::Address.state }
    place_code  { Faker::Number.unique.between(from: 1, to: 48) }
  end
end
