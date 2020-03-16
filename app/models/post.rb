class Post < ApplicationRecord
  paginates_per 10
  belongs_to :user
  has_many :comments, as: :commentable
end
