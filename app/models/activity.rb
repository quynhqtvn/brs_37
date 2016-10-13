class Activity < ApplicationRecord
  belongs_to :user

  validates :target_id, :user_id, presence: true

  enum action_type: ["read", "favorite", "follow", "review", "comment"]

  def timeline
    case action_type
    when "folow"
      t "activity.follow"
    when "review"
      t "activity.review"
    when "comment"
      t "activity.comment"
    end
  end

  def target
    if follow?
      User.find_by id: target_id
    elsif review?
      Review.find_by id: target_id
    elsif comment?
      Comment.find_by id: target_id
    end
  end
end
