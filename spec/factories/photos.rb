FactoryBot.define do
  factory :photo do
    path { Rack::Test::UploadedFile.new(Rails.root.join('db', 'seeds', 'images', '01.jpg'), 'image/jpg') }
    date { Faker::Date.backward }
    age  { Faker::Number.between(from: 3, to: 18) }
    association :user, factory: :user
    association :variety, factory: :variety
    association :place, factory: :place
    published

    trait :published do published { true } end
    trait :unpublished do published { false } end
  end
end
