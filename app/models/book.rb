class Book < ApplicationRecord
  validates :book_subject, presence: true
  belongs_to :user
  belongs_to :genre, optional: true
end

