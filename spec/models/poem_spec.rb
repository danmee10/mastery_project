require 'spec_helper'

describe Poem do
  let(:subject) { Poem.create(title: "Test Poem", original_text: "some text", poem_text: "altered text is fun to write. yay for this thing!")}

  its(:original_text) { "some text" }
  its(:poem_text) { "altered text is fun to write. yay for this thing!" }
  its(:title) { "Test Poem" }

  it "validates presence of original_text" do
    poem = Poem.new(poem_text: "altered text is fun to write. yay for this thing!")
    expect(poem.save).to be_false
  end

  describe "#verse_form" do
    context "given an original_text of more than 32 syllables" do
      it "breaks the poem_text into an array of stanzas containing no more than 4 lines of no more than 8 syllables" do
        poem = Poem.create(original_text: "This is a block of text that has more than the necessary 32 syllables that are required for this test to be valid.")
        poem.poem_text = poem.original_text
        expect(poem.verse_form).to eq [["This is a block of text that has", "more than the necessary", "32 syllables that are", "required for this test to be"], ["valid."]]
        expect(poem.verse_form.class).to eq Array
        expect(poem.verse_form.first.class).to eq Array
        expect(poem.verse_form.first.size).to eq 4
        expect(poem.verse_form.first.first.class).to eq String
        expect(Word.syllables(poem.verse_form.first.first)).to eq 8
        expect(poem.verse_form.first.first).to eq "This is a block of text that has"
      end
    end
  end

  describe "#replace(old_word, new_word)" do
    context "given the index of a word in the poem's poem_text, and a single word string" do
      it "inserts the new_word at the given index point" do
        subject.replace(5, "make")
        expect(subject.poem_text).to eq "altered text is fun to make. yay for this thing!"
      end
    end
  end
end
