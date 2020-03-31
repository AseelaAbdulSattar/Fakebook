class Comment < ApplicationRecord
  searchkick suggest: [:body]
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :replies, as: :commentable, class_name: "Comment", dependent: :destroy
end
