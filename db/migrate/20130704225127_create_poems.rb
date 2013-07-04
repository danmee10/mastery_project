class CreatePoems < ActiveRecord::Migration
  def change
    create_table :poems do |t|
      t.text :original_text
      t.text :poem_text

      t.timestamps
    end
  end
end
