class Report < ApplicationRecord
  belongs_to :user
  belongs_to :reportable, polymorphic: true
  validates :user_id, uniqueness: { scope: [ :reportable_type, :reportable_id], message: "You have already Reported it." }
  #msg not showing
end
