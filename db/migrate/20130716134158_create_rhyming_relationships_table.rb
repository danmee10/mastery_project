class CreateRhymingRelationshipsTable < ActiveRecord::Migration
  def change
    create_table :rhyming_relationships do |t|
      t.integer :word_id
      t.integer :rhyme_id

      t.timestamps
    end
    add_index :rhyming_relationships, :word_id
    add_index :rhyming_relationships, :rhyme_id
  end
end
