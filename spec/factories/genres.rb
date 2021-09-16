FactoryBot.define do
  factory :genre do
    genre_name {Faker::Lorem.sentence}
    association :user 
  end
end
