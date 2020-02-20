class User < ApplicationRecord
  paginates_per 5
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :friendships
  has_many :friends, -> { where( friendships: {status: true})}, through: :friendships
  has_many :pending_friends, -> { where( friendships: {status: nil})}, through: :friendships

  def self.all_except(user)
    ids = user.pending_friends.ids << user.id
    where.not(id:  ids += user.friends.ids)
  end

  def friend_requests
    User.where(id: Friendship.where(friend_id: id, status: nil).pluck(:user_id))
  end
end
