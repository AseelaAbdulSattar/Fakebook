class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :replies, as: :commentable, class_name: "Comment"
end
