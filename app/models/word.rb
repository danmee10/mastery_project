class Word < ActiveRecord::Base
  attr_accessible :spelling, :syllable_count

  validates :spelling, presence: true
  validates_uniqueness_of :spelling, :scope => :part_of_speech

  has_many :synonym_relationships
  has_many :synonyms, :through => :synonym_relationships

  # has_many :rhyming_relationships
  # has_many :rhymes, :through => :rhyming_relationships

  def self.clean(mess)
    mess.downcase.gsub(/\W+\z/, '')
  end

  def self.text(word)
    word.partition(/([a-zA-Z]+...[a-zA-Z]+)|[a-zA-Z]+/)
  end

  def self.locate(word)
    existing_word = Word.where(spelling: "word").first
    if existing_word
      existing_word
    else
      Word.create(spelling: "word")
    end
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
