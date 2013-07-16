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
        expect(Word.clean("what's.")).to eq "what's"
      end
    end
  end

  describe ".text(word)" do
    context "given a string containing a word and punctuation" do
      it "separates the word from the punctuation on either side of it and returns a three part array" do
        expect(Word.text("(what's?)")).to eq ["(", "what's", "?)"]
        expect(Word.text("first-class?[1][2]")).to eq ["", "first-class", "?[1][2]"]
        expect(Word.text("a")).to eq ["", "a", ""]
      end
    end
  end

  describe ".syllables(word)" do
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

  describe ".locate(word)" do
    context "given a string" do
      it "returns a word object with that spelling" do
        expect(Word.locate("word").class).to eq Word
        expect(Word.locate("word").spelling).to eq "word"
      end
    end
  end

  describe "synonym_lookup" do
    context "given a word object with saved synonyms" do
      it "returns an array of the synonyms" do
        word = Word.create(spelling: "word")
        word2 = Word.create(spelling: "phrase")
        word.synonyms << word2
        expect(word.synonym_lookup.class).to eq Array
        expect(word.synonym_lookup.first.spelling).to eq "phrase"
      end
    end

    context "given a word object with no saved synonyms" do
      it "looks the word up in a thesaurus and returns an array of the synonyms" do
        word = Word.create(spelling: "word")
        expect(word.synonym_lookup.class).to eq Array
        expect(word.synonym_lookup.first.spelling).to eq "news"
      end
    end
  end

  describe "rhyme_lookup" do
    context "given a word object with saved rhymes" do
      it "returns an array of the rhymes" do
        word = Word.create(spelling: "word")
        word2 = Word.create(spelling: "bird")
        word.rhymes << word2
        expect(word.rhyme_lookup.class).to eq Array
        expect(word.rhyme_lookup.first.spelling).to eq "bird"
      end
    end

    context "given a word object with no saved rhymes" do
      it "looks the word up in a rhyming dictionary and returns an array of the rhymes" do
        word = Word.create(spelling: "word")
        expect(word.rhyme_lookup.class).to eq Array
        expect(word.rhyme_lookup.first.spelling).to eq "heard"
      end
    end
  end
end
