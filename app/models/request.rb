class Request < ApplicationRecord
  extend DatabaseQuery
  belongs_to :user

  delegate :name, to: :user
end
