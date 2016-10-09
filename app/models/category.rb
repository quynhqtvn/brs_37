class Category < ApplicationRecord
  extend DatabaseQuery
  validates :name, uniqueness: {case_sensitive: true}

  has_many :books, dependent: :destroy
end
