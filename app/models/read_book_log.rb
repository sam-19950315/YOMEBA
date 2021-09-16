class ReadBookLog < ApplicationRecord
  validates :log, presence: true
  belongs_to :user
  belongs_to :book
end
