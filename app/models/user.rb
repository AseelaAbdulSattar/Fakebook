class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :friendships
  has_many :friends, through: :friendships

  def self.all_except(user)
    where.not(id: user)
  end

  
end
