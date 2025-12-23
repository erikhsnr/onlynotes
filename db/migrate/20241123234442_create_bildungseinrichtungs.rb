class CreateBildungseinrichtungs < ActiveRecord::Migration[8.0]
  def change
    create_table :bildungseinrichtungs do |t|
      t.string :name
      t.string :ort

      t.timestamps
    end
  end
end
