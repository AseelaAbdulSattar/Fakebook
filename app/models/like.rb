class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true

  def total_likes
    self.likes.size
  end
end
