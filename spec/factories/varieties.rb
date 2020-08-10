FactoryBot.define do
  factory :variety do
    name { Faker::Device.model_name }
    sequence(:variety_code) { |n| Faker::Device.model_name + "(#{n})" }
    association :product, factory: :product
  end
end
