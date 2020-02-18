class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"
  validates :friend_id, uniqueness: { scope: :user_id, message: "Already Sent" }
  scope :friends, -> {where(status: true)}
  #scope :friends, -> {where(friend_id: User.current.id).or(where( user_id: User.current.id)).and(where(status: true))}

  def exist_friend_id
    if !Friendship.exists?(friend_id: id)
      errors.add(:base, 'No- Request Exists')
    end
  end

  def self.existing_friends(user_id, friend_id)
    find_by_user_id_and_friend_id(user_id, friend_id)
  end
  
  
  after_update :update_inverse , unless: :has_inverse?
  after_destroy :destroy_inverses, if: :has_inverse?

  def update_inverse
    if saved_change_to_attribute?('status')
      if status == true
        self.class.create(inverse_options)
      end
    end
  end

  def create_inverse
    self.class.create(inverse_options)
  end

  def destroy_inverses
    inverses.destroy_all
  end

  def has_inverse?
    self.class.exists?(inverse_options)
  end

  def inverses
    self.class.where(inverse_options)
  end

  def inverse_options
    { friend_id: user_id, user_id: friend_id, status: true }
  end

end
