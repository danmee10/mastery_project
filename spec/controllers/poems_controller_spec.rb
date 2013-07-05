require 'spec_helper'

describe PoemsController do
  describe 'POST #create' do
    it 'creates a new poem' do
      params = {poem: { original_text: "Words for editing." }}
      post :create, params
      expect(Poem.count).to eq 1
      expect(assigns[:poem].poem_text).to eq "Words for editing."
      expect(assigns[:poem].original_text).to eq "Words for editing."
    end
  end

  describe 'GET #edit' do
    it 'receives a poem with original_text' do
      poem = Poem.create(original_text: "Words for editing.")
      params = {id: 1}
      get :edit, params
      expect(poem.original_text).to eq "Words for editing."
    end

    it 'defines poem_text as the original text split into default lines and stanzas' do
      poem = Poem.create(original_text: "Words for editing are fun to edit because they are not rhyming yet.")
      params = {id: 1}
      get :edit, params
      expect(poem.poem_text).to eq "Words for editing."
    end
  end
end
