FactoryBot.define do
  factory :photo do
    path { Faker::File.file_name(ext: 'jpg') }
    date { Faker::Date.backward }
    age  { Faker::Number.between(3, 18) }
    association :user, factory: :user
    association :variety, factory: :variety
    association :place, factory: :place
    published

    trait :published do published { true } end
    trait :unpublished do published { false } end
  end
end
