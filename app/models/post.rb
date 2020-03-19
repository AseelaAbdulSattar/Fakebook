class Post < ApplicationRecord
  self.per_page = 10
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  accepts_nested_attributes_for :comments, allow_destroy: true
end
