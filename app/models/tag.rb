class Tag < ApplicationRecord
  extend DatabaseQuery
  has_many :book_tags, dependent: :destroy
  has_many :books, through: :book_tags

  validates :name, presence: true, uniqueness: {case_sensitive: true}
end
