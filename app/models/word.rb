class Word < ActiveRecord::Base
  attr_accessible :spelling, :syllable_count

  validates :spelling, presence: true

  def self.clean(mess)
    mess.downcase.gsub(/\W+\z/, '')
  end

  def self.text(word)
    word.partition(/([a-zA-Z]+...[a-zA-Z]+)|[a-zA-Z]+/)
  end

  def self.syllables(word)
    # existing_word = find_by_spelling(word)
    # if existing_word
    #   existing_word.syllable_count
    # else
      Odyssey.flesch_kincaid_re("#{word}", true)["syllable_count"]
    # end
  end
end
