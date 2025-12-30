class InitSolidCache < ActiveRecord::Migration[8.0]
  def up
    load Rails.root.join("db/cache_schema.rb")
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end