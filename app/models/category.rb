class Category < ApplicationRecord
  validates :name, uniqueness: {case_sensitive: true}

  has_many :books
end
