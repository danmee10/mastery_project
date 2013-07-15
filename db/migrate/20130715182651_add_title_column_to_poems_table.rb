class AddTitleColumnToPoemsTable < ActiveRecord::Migration
  def change
    add_column :poems, :title, :string, default: "Untitled"
  end
end
