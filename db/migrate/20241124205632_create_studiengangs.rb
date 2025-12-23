class CreateStudiengangs < ActiveRecord::Migration[8.0]
  def change
    create_table :studiengangs do |t|
      t.string :name

      t.references :fachbereich, null: false, foreign_key: {to_table: :fachbereiches}

      t.timestamps
    end
  end
end
