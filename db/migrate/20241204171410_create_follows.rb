class CreateFollows < ActiveRecord::Migration[8.0]
  def change
    create_table :follows do |t|
      t.references :user, null: false, foreign_key: true
      t.references :fach, null: false, foreign_key: true

      t.timestamps
    end
  end
end
