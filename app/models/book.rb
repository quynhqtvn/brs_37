class Book < ApplicationRecord
  belongs_to :category

  has_many :reviews
  has_many :book_users
  has_many :users, through: :book_users
  has_many :book_tags
  has_many :tags, through: :book_tags
end
