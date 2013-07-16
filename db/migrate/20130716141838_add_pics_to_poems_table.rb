class AddPicsToPoemsTable < ActiveRecord::Migration
  def change
    add_column :poems, :pic, :string
  end
end
