class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :body
      t.string :commentable_type
      t.integer :commentable_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
