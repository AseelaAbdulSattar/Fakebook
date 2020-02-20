class User < ApplicationRecord
  paginates_per 5
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :friendships
  has_many :friends, -> { where( friendships: {status: true})}, through: :friendships

  def self.all_except(user)
    where.not(id: Friendship.where(user_id: user.id).pluck(:friend_id) << user.id)
  end

  def pending_friends
    User.where(id: Friendship.where(friend_id: id, status: nil).pluck(:user_id))
  end

  def sent_requests
    User.where(id: Friendship.where(user_id: id, status: nil).pluck(:friend_id))
  end
end
