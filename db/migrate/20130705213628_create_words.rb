class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :spelling
      t.integer :syllable_count

      t.timestamps
    end
  end
end
