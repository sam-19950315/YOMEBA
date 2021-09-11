class ReadBookLog < ApplicationRecord
  validates :read_day, presence: true
  belongs_to :user
  belongs_to :book
  belongs_to :genre
end
