class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.integer :reportable_id
      t.string :reportable_type
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
