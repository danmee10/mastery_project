class AddPicsToPoemsTable < ActiveRecord::Migration
  def change
    add_column :poems, :pic, :string, default: "http://www.sook.org/uploads/6/8/4/7/6847693/so_oklahoma_mark_xxx_xxx-24.jpg"
    add_column :poems, :public_poem, :boolean, default: true
  end
end
