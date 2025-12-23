class AddUserIdToFach < ActiveRecord::Migration[8.0]
  def change
    add_column :faches, :user_id, :integer
  end
end
