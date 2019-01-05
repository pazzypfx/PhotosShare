FactoryBot.define do
  factory :variety do
    name { Faker::Device.model_name }
    variety_code  { Faker::Device.model_name }
    association :product, factory: :product
  end
end
