class CreateFaches < ActiveRecord::Migration[8.0]
  def change
    create_table :faches do |t|
      t.string :name
      t.string :dozenten
      
      t.references :studiengang, null: false, foreign_key: {to_table: :studiengangs}

      t.timestamps
    end
  end
end
