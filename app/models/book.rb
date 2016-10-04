class Book < ApplicationRecord
  extend DatabaseQuery

  belongs_to :category

  has_many :reviews
  has_many :book_users
  has_many :users, through: :book_users
  has_many :book_tags
  has_many :tags, through: :book_tags

  scope :of_category, -> category_id {where category_id: category_id if category_id.present?}
end
