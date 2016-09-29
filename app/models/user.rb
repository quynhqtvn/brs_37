class User < ApplicationRecord
  has_many :comments
  has_many :requests
  has_many :book_users
  has_many :books, through: :book_users
  has_many :active_relationships, class_name: Relationship.name, 
    foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name, 
    foreign_key: "followed_id", dependent: :destroy 
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
end
