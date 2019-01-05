FactoryBot.define do
  factory :place do
    name { Faker::Address.state }
    place_code  { Faker::Number.unique.between(1, 48) }
  end
end
