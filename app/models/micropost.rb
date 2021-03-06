class Micropost < ActiveRecord::Base
  include MicropostsHelper
  attr_accessible :content
  belongs_to :user

  validates :content, :presence => true, :length => { :maximum => 140 }
  validates :user_id, :presence => true
  
  has_many :appreciations, :foreign_key => :liked_id, :dependent => :destroy
  has_many :likers, :through => :appreciations, :source => :liker

  default_scope :order => 'microposts.created_at DESC'

  # Return microposts from the users being followed by the given user.
  scope :from_users_followed_by, lambda { |user| followed_by(user) }

#  def content
#    wrap((read_attribute :content).to_s)
#  end

  private
      # Return an SQL condition for users followed by the given user.
    # We include the user's own id as well.
    def self.followed_by(user)
      followed_ids = %(SELECT followed_id FROM relationships
                       WHERE follower_id = :user_id)
      where("user_id IN (#{followed_ids}) OR user_id = :user_id",
            { :user_id => user })
    end
  
end

