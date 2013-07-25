class Poem < ActiveRecord::Base
  attr_accessible :original_text, :poem_text, :max_lines, :max_syllables, :title, :pic, :public_poem

  belongs_to :user

  validates :original_text, presence: true
  validates :max_lines, :numericality => {:greater_than => 0, :message => "You must at least one line in a stanza" }
  validates :max_syllables, :numericality => {:greater_than => 0, :message => "You must at least one syllable in a line" }

  def default_verse_form
    dirty_words_array = poem_text.split(" ")
    lines_array(dirty_words_array).each_slice(max_lines).to_a
  end

  def replace(index, word)
    edit = poem_text.split(" ")
    punctuation = edit[index].scan(/\W+\z/).pop
    if punctuation == nil
      edit[index] = word
    else
      edit[index] = word + punctuation
    end
    update_attributes(poem_text: edit.join(" "))
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
          all_lines << current_line.join(" ")
        end

      else
        all_lines << current_line.join(" ")
        current_line = [word]
        line_syllables = word_sylls

        if word == dirty_words_array.last
          all_lines << current_line.join(" ")
        end

      end
    end

    return all_lines
  end
end
