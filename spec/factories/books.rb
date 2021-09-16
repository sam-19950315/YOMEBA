FactoryBot.define do
  factory :book do    
    book_subject {Faker::Lorem.sentence}
    association :user 
    association :genre
  end
end
