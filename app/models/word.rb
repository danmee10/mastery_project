class Word < ActiveRecord::Base
  attr_accessible :spelling, :syllable_count

  validates :spelling, presence: true

  has_many :synonym_relationships
  has_many :synonyms, :through => :synonym_relationships

  has_many :rhyming_relationships
  has_many :rhymes, :through => :rhyming_relationships

  def self.clean(mess)
    mess.downcase.gsub(/\W+\z/, '')
  end

  def self.text(word)
    word.partition(/([a-zA-Z]+...[a-zA-Z]+)|[a-zA-Z]+|[0-9]+/)
  end

  def self.locate(word)
    existing_word = Word.where(spelling: word).first
    if existing_word
      existing_word
    else
      Word.create(spelling: word)
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

  def rhyme_lookup
    if rhymes.first
      rhymes
    else
      lookup_and_add_rhymes
    end
  end

  def lookup_and_add_rhymes
    rhyming_dictionary.each do |syn|
      rhymes << syn
    end
    rhymes
  end

  def rhyming_dictionary
    full_response = HTTParty.get("http://rhymebrain.com/talk?function=getRhymes&word=#{spelling}")
    rhymes = rhyme_brain_parser(full_response).collect do |response|
      if Word.find_by_spelling(response[:word])
        Word.find_by_spelling(response[:word]).update_attributes(syllable_count: response[:syllables])
        Word.find_by_spelling(response[:word])
      else
        Word.create(spelling: response[:word], syllable_count: response[:syllables])
      end
    end
  end

  def rhyme_brain_parser(response)
    real_words = response.select { |rhyme| rhyme["flags"].to_s.match(/b/) != nil }
    real_words.collect { |rhyme| {word: rhyme["word"], syllables: rhyme["syllables"].to_i} }
  end

  def synonym_lookup
    if synonyms.first
      synonyms
    else
      lookup_and_add_synonyms
    end
  end

  def lookup_and_add_synonyms
    thesaurus.each do |syn|
      synonyms << syn
    end
    synonyms
  end

  def thesaurus
    key = ENV['THESAURUS_KEY']
    full_response = HTTParty.get("http://words.bighugelabs.com/api/2/#{key}/#{spelling}/json")
    unless full_response == ''
      word_objects_array = thesaurus_parser(full_response).collect do |word|
        if Word.find_by_spelling(word)
          Word.find_by_spelling(word)
        else
          Word.create(spelling: word)
        end
      end
    end
    word_objects_array ? word_objects_array : []
  end

  def thesaurus_parser(response)
    a = []
    if response['noun']
      a << response['noun']['syn']
    end
    if response['verb']
      a << response['verb']['syn']
    end
    if response['adverb']
      a << response['adverb']['syn']
    end
    if response['adjective']
      a << response['adjective']['syn']
    end
    a.flatten
  end
end
