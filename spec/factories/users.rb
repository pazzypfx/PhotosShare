FactoryBot.define do
  factory :user do
    username { Faker::Internet.unique.username }
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    password { '123456' }
    admin

    trait :admin do role { 'admin' } end
    trait :manager do role { 'manager' } end
    trait :agent do role { 'agent' } end
  end
end
