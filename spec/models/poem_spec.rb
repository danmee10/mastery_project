require 'spec_helper'

describe Poem do
  let(:subject) { Poem.create(original_text: "some text", poem_text: "altered text")}

  its(:original_text) { "some text" }
  its(:poem_text) { "altered text" }

  it "validates presence of original_text" do
    poem = Poem.new(poem_text: "altered text")
    expect(poem.save).to be_false
  end
end
