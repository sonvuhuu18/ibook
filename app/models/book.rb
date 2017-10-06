class Book < ApplicationRecord
  belongs_to :user
  has_many :book_categories, dependent: :destroy
  has_many :categories, through: :book_categories
  has_many :reviews, dependent: :destroy

  validates :title, presence: true
  validates :author, presence: true
  validates :public_year, inclusion: 1800..2100
  validate :has_categories
  mount_uploader :cover, BookCoverUploader
  validates_presence_of :cover
  validates_integrity_of :cover
  validates_processing_of :cover

  private

  def has_categories
    errors.add(:base, "One of the categories must be checked") unless categories.size > 0
  end
end
