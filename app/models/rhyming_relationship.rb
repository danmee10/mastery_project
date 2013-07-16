class RhymingRelationship < ActiveRecord::Base

  belongs_to :word
  belongs_to :rhyme, :class_name => "Word"
end
