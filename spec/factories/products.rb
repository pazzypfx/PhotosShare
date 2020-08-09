FactoryBot.define do
  factory :product do
    name { Faker::Device.model_name }
    sequence(:product_code) { |n| Faker::Device.model_name + "(#{n})" }
  end
end
