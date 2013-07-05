class Poem < ActiveRecord::Base
  attr_accessible :original_text, :poem_text, :max_lines, :max_syllables

  validates :original_text, presence: true

  def default_verse_form
    dirty_words_array = poem_text.split(" ")
    lines_array(dirty_words_array).each_slice(max_lines).to_a
  end

private
  def lines_array(dirty_words_array)
    current_line = []
    all_lines = []
    line_syllables = 0

    dirty_words_array.each do |word|
      clean_word = Word.clean(word)
      word_sylls = Word.syllables(clean_word)

      if (line_syllables + word_sylls) <= max_syllables
        line_syllables += word_sylls
        current_line << word

        if word == dirty_words_array.last
          all_lines << current_line
        end

      else
        all_lines << current_line.join(" ")
        current_line = [word]
        line_syllables = word_sylls

        if word == dirty_words_array.last
          all_lines += current_line
        end

      end
    end

    return all_lines
  end
end
