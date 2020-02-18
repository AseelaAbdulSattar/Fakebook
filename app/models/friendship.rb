class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"
  validates :friend_id, uniqueness: { scope: :user_id, message: "Already Sent" }
  scope :friends, -> {where(status: true)}
  
  after_update :add_friend , unless: :already_friends?
  after_destroy :destroy_friend, if: :already_friends?

  def self.existing_friends(user_id, friend_id)
    find_by_user_id_and_friend_id(user_id, friend_id)
  end

  def add_friend
    if saved_change_to_attribute?('status')
      if status == true
        self.class.create(inverse_options)
      end
    end
  end

  def destroy_friend
    inverses.destroy_all
  end

  def already_friends?
    self.class.exists?(inverse_options)
  end

  def inverses
    self.class.where(inverse_options)
  end

  def inverse_options
    { friend_id: user_id, user_id: friend_id, status: true }
  end

end
