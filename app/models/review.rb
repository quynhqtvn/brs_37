class Review < ApplicationRecord
  extend DatabaseQuery
  belongs_to :user
  belongs_to :book

  has_many :comments
end
