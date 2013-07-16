class AddPicsToPoemsTable < ActiveRecord::Migration
  def change
    add_column :poems, :pic, :string, default: "http://3.bp.blogspot.com/_D274vwEvfTU/S7IL0L3yCoI/AAAAAAAAAFc/2qnq3yss6SI/s200/Happiness_1.jpg"
  end
end
