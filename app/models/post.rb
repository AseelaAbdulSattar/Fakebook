class Post < ApplicationRecord
  searchkick suggest: [:text]
  self.per_page = 10
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :reports, as: :reportable, dependent: :destroy
  accepts_nested_attributes_for :comments, allow_destroy: true
end
