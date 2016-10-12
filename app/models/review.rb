class Review < ApplicationRecord
  extend DatabaseQuery
  belongs_to :user
  belongs_to :book

  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: {maximum: 50}
  validates :content, presence: true, length: {minimum: 50}
  validates :rate, presence: true

  delegate :name, to: :user

  scope :count_rate, ->value{where(rate: value).count(:rate)}
end
