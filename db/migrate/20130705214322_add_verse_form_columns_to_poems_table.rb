class AddVerseFormColumnsToPoemsTable < ActiveRecord::Migration
  def change
    change_table :poems do |t|
      t.integer :max_syllables, default: 8
      t.integer :max_lines, default: 4
    end
  end
end
