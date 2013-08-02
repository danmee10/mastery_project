class Poem < ActiveRecord::Base
  attr_accessible :original_text, :poem_text, :max_lines, :max_syllables, :title, :pic, :public_poem

  belongs_to :user

  validates :original_text, presence: true
  validates :max_lines, :numericality =>
                            {:greater_than => 0, :message => "You must have at least one line in a stanza" }
  validates :max_syllables, :numericality =>
                                {:greater_than => 0, :message => "You must have at least one syllable in a line" }

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

  def verse_form
    syllable_lines.each_slice(max_lines).to_a
  end

private
  def words_with_punctuation
    poem_text.split(" ")
  end

  def syllable_lines
    # transform words_with_punctuation into an array of lines with a certain number of syllables

    # iterate over the array, and join words together until
    current_line = []
    all_lines = []
    line_syllables = 0

    words_with_punctuation.each do |word|
      clean_word = Word.clean(word)
      word_sylls = Word.syllables(clean_word)

      if (line_syllables + word_sylls) <= max_syllables
        line_syllables += word_sylls
        current_line << word

        is_last_word({word: word,
                      line: current_line,
                     lines: all_lines})

      else
        all_lines << current_line.join(" ")
        current_line = [word]
        line_syllables = word_sylls

        is_last_word({word: word,
                      line: current_line,
                     lines: all_lines})

      end
    end

    return all_lines
  end

  def is_last_word(args)
    if args[:word] == words_with_punctuation.last
      args[:lines] << args[:line].join(" ")
    end
  end
end

# def lines_array(dirty_words_array)
#     current_line = []
#     all_lines = []
#     line_syllables = 0

#     dirty_words_array.each do |word|
#       clean_word = Word.clean(word)
#       word_sylls = Word.syllables(clean_word)

#       if (line_syllables + word_sylls) <= max_syllables
#         line_syllables += word_sylls
#         current_line << word

#         if word == dirty_words_array.last
#           all_lines << current_line.join(" ")
#         end

#       else
#         all_lines << current_line.join(" ")
#         current_line = [word]
#         line_syllables = word_sylls

#         if word == dirty_words_array.last
#           all_lines << current_line.join(" ")
#         end

#       end
#     end

#     return all_lines
#   end
