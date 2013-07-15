class AddUserIdToPoemsTable < ActiveRecord::Migration
  def change
    add_column :poems, :user_id, :integer
    add_index :poems, :user_id
  end
end
