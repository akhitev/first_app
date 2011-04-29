class Appreciation < ActiveRecord::Base

  belongs_to :liker, :class_name => "User"
  belongs_to :liked, :class_name => 'Micropost'

  validates :liker_id, :presence => true
  validates :liked_id, :presence => true
  validate :can_not_like_own_posts

  def can_not_like_own_posts
    errors.add(:liked_id, "user can't like own post") if
        liked.user_id == liker_id
  end
end
