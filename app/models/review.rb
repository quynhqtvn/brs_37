class Review < ApplicationRecord
  extend DatabaseQuery
  belongs_to :user
  belongs_to :book

  has_many :comments

  validates :title, presence: true, length: {maximum: 50}
  validates :content, presence: true, length: {minimum: 50}
  validates :rate, presence: true
end
