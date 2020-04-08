class AddIndexToReport < ActiveRecord::Migration[6.0]
  def change
    add_index :reports, [:user_id, :reportable_type, :reportable_id], unique:  true
  end
end
