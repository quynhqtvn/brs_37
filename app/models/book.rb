class Book < ApplicationRecord
  extend DatabaseQuery

  belongs_to :category

  has_many :reviews
  has_many :book_users
  has_many :users, through: :book_users
  has_many :book_tags, dependent: :destroy
  has_many :tags, through: :book_tags

  has_attached_file :book_img, styles: {book_index: "100x100>>", book_show: "200x300>"},
    default_url: "/images/:style/missing.png"
  validates_attachment_content_type :book_img, content_type: /\Aimage\/.*\z/
  validates :title, presence: true, length: {maximum: 30}
  validates :description, presence: true
  validates :category, presence: true
  validates :author, presence: true

  scope :search, -> search {where "title LIKE ?", "#{search}%"}
end
