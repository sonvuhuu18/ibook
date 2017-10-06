class Review < ApplicationRecord
  belongs_to :book
  belongs_to :user
  validates :content, presence: true,
    length: {minimum: 6, maximum: 1000}
  validates :rating, presence: true
end
