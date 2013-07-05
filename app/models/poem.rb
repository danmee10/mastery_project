class Poem < ActiveRecord::Base
  attr_accessible :original_text, :poem_text

  validates :original_text, presence: true

  def default_verse_form
    stanzas_array = []
    stanza = []
    line_array = []
    line_syllables = 0

    poem_text.split(" ").each do |word|
      clean_word = Word.clean(word)
      word_sylls = Word.syllables(clean_word)

      if (line_syllables + word_sylls) < max_syllables
        line_syllables += word_sylls
        line_array << word
      else
        if stanza.count < max_lines
          stanza << line_array.join(" ")
        else
          stanzas_array << stanza
          stanza = [line_array.join(" ")]
        end
        line_array = [word]
        line_syllables = word_sylls
      end
    end

    return stanzas_array
  end


end
