class Genre < ApplicationRecord
  validates :genre_name, presence: true
  belongs_to :user
  has_many :books
end
