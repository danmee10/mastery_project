require 'spec_helper'

describe Poem do
  let(:subject) { Poem.create(original_text: "some text", poem_text: "altered text")}

  its(:original_text) { "some text" }
  its(:poem_text) { "altered text" }

  it "validates presence of original_text" do
    poem = Poem.new(poem_text: "altered text")
    expect(poem.save).to be_false
  end

  describe "#default_verse_form" do
    context "given an original_text of more than 32 syllables" do
      it "breaks the poem_text into an array of stanzas containing no more than 4 lines of no more than 8 syllables" do
        poem = Poem.create(original_text: "This is a block of text that has more than the necessary 32 syllables that are required for this test to be valid.")
        poem.poem_text = poem.original_text
        expect(poem.default_verse_form).to eq [["This is a block of text that has", "more than the necessary", "32 syllables that are", "required for this test to be"], ["valid."]]
        expect(poem.default_verse_form.class).to eq Array
        expect(poem.default_verse_form.first.class).to eq Array
        expect(poem.default_verse_form.first.size).to eq 4
        expect(poem.default_verse_form.first.first.class).to eq String
        expect(Word.syllables(poem.default_verse_form.first.first)).to eq 8
        expect(poem.default_verse_form.first.first).to eq "This is a block of text that has"
      end
    end
  end
end
