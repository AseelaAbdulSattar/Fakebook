class AddcolumtoUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :state, :string, default: 'active'
  end
end
