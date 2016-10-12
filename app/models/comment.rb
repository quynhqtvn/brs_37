class Comment < ApplicationRecord
  extend DatabaseQuery
  belongs_to :user
  belongs_to :review

  delegate :name, to: :user
end
