class Poem < ActiveRecord::Base
  attr_accessible :original_text, :poem_text

  validates :original_text, presence: true
end
