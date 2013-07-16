class CreateSynonymRelationshipsTable < ActiveRecord::Migration
  def change
    create_table :synonym_relationships do |t|
      t.integer :word_id
      t.integer :synonym_id

      t.timestamps
    end
    add_index :synonym_relationships, :word_id
    add_index :synonym_relationships, :synonym_id
  end
end
