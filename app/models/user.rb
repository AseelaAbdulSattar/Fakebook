class User < ApplicationRecord
  paginates_per 5
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :friendships
  has_many :friends, through: :friendships

  def self.all_except(user)
    where.not(id: Friendship.where(user_id: user.id).pluck(:friend_id) << user.id)
  end
  
  def self.friends(user)
    where(id: Friendship.where(user_id: user.id, status: true).pluck(:friend_id))
  end

  def self.pending_friends(user)
    where(id: Friendship.where(friend_id: user.id, status: nil).pluck(:user_id))
  end

  def self.sent_requests(user)
    where(id: Friendship.where(user_id: user.id, status: nil).pluck(:friend_id))
  end
  
end
