class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.integer :likes
      
      t.references :fach, null: false, foreign_key: {to_table: :faches}

      t.timestamps
    end
  end
end
