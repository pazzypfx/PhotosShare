FactoryBot.define do
  factory :product do
    name { Faker::Device.model_name }
    product_code  { Faker::Device.model_name }
  end
end
