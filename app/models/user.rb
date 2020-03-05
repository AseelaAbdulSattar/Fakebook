class User < ApplicationRecord

  paginates_per 2
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :friendships
  has_many :friendships_requests_received,-> { where( friendships: {status: nil})}, foreign_key: 'friend_id', class_name: 'Friendship'
  has_many :friends, -> { where( friendships: {status: true})}, through: :friendships
  has_many :friendships_requests_sent, -> { where( friendships: {status: nil})}, through: :friendships

  def self.all_except(user)
    ids = user.friendships_requests_sent.ids << user.id
    where.not(id:  ids += user.friends.ids)
  end

  def self.to_csv
    attributes = %w{ name state email total_Friends}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        csv << attributes.map{ |attr| user.send(attr) }
      end
    end
  end

  def total_Friends
    friends.count
  end

end
