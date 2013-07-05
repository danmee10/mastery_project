require 'spec_helper'

describe Word do
  let(:subject) { Word.create(spelling: "word", syllable_count: 1)}

  its(:spelling) { "word" }
  its(:syllable_count) { 1 }

  it "validates presence of spelling" do
    word = Word.new(syllable_count: 3)
    expect(word.save).to be_false
  end

  describe ".clean(mess)" do
    context "given a string" do
      it "removes punctuation from the end of a word" do
        expect(Word.clean("forgot?")).to eq "forgot"
        expect(Word.clean("forgot...")).to eq "forgot"
      end

      it "includes apostrophes for contractions" do
        expect(Word.clean("what's")).to eq "what's"
      end
    end
  end

  describe ".syllable_count(word)" do
    context "given a word that isn't in the database" do
      it "returns the number of syllables in that word" do
        expect(Word.syllables("word")).to eq 1
      end
    end

    context "given a word that is in the database" do
      it "returns the number of syllables in that word" do
        Word.create(spelling: "word", syllable_count: 1)
        expect(Word.syllables("word")).to eq 1
      end
    end
  end
end
