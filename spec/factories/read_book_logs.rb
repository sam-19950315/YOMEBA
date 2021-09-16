FactoryBot.define do
  factory :read_book_log do
    log              {Faker::Date.between(from: '2020-01-1', to: '2021-09-16')}
    association :user
    association :book
  end
end