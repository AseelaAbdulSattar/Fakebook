class AddDefaultValueToFriendshipsStatus < ActiveRecord::Migration[6.0]
  def change
    change_column :friendships, :status, :boolean, default: nil
  end
end
