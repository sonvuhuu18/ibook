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
  scope :search_by_title, ->(keyword) do
    where(pending: false).where("title LIKE ?" , "%#{keyword}%")
  end
  scope :search_by_author, ->(keyword) do
    where(pending: false).where("author LIKE ?", "%#{keyword}%")
  end
  scope :search_by_public_year, ->(keyword) do
    where(pending: false, public_year: keyword)
  end
  scope :recently_reviewed, -> do
    where(pending: false).includes(:reviews).order("reviews.created_at desc").uniq
  end
  scope :pending, -> do
    where(pending: true)
  end
  scope :accepted, -> do
    where(pending: false)
  end

  private

  def has_categories
    errors.add(:base, "One of the categories must be checked") unless categories.size > 0
  end
end
