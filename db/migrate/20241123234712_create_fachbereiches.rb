class CreateFachbereiches < ActiveRecord::Migration[8.0]
  def change
    create_table :fachbereiches do |t|
      t.string :name
      t.references :bildungseinrichtung, null: false, foreign_key: {to_table: :bildungseinrichtungs}

      t.timestamps
    end
  end
end
