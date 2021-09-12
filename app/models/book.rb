class Book < ApplicationRecord
  validates :book_subject, presence: true
  belongs_to :user
  belongs_to :genre
  has_many :read_book_logs, dependent: :destroy
end

